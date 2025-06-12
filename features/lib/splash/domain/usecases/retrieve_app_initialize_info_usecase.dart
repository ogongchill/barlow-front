import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/domain/repositories/user_reject_repository.dart';
import 'package:features/splash/domain/entities/app_initialize_info.dart';
import 'package:features/splash/domain/entities/app_version_status.dart';
import 'package:features/splash/domain/repositories/app_initialize_info_repository.dart';
import 'package:features/splash/domain/repositories/app_version_status_repository.dart';

class AppInitializeStatus {

  final bool isFirstLaunch;
  final bool isUpdateAvailable;
  final bool needForceUpdate;
  final bool isLoggedIn;
  final bool hasCheckNotificationPermission;
  final bool hasRejectUpdateDialog;

  AppInitializeStatus({
      required this.isFirstLaunch,
      required this.isUpdateAvailable,
      required this.needForceUpdate,
      required this.isLoggedIn,
      required this.hasCheckNotificationPermission,
      required this.hasRejectUpdateDialog
  });
}

class RetrieveAppInitializeInfoUseCase {

  final AppInitializeInfoRepository _repository;
  final AppVersionStatusRepository _appVersionStatusRepository;
  final UserRejectRepository _userRejectRepository;

  RetrieveAppInitializeInfoUseCase({required AppInitializeInfoRepository appInitializeInfoRepository, required AppVersionStatusRepository appVersionStatusRepository, required UserRejectRepository userRejectRepository})
    : _repository = appInitializeInfoRepository,
      _appVersionStatusRepository = appVersionStatusRepository,
      _userRejectRepository = userRejectRepository;

  Future<AppInitializeStatus> execute() async {
    AppInitializeInfo info = await _repository.retrieve();
    AppVersionStatus versionStatus = await _appVersionStatusRepository.fetchVersionInfo();
    final rejectUpdateDialog = await _userRejectRepository.findByCategory(UserRejectCategory.updateAvailableDialog);
    bool hasRejectDialog = (rejectUpdateDialog != null) && (rejectUpdateDialog.expiredAt.isAfter(DateTime.now()));
    return AppInitializeStatus(
      isFirstLaunch: info.isFirstLaunch,
      isLoggedIn: info.isLoggedIn,
      hasCheckNotificationPermission: info.hasCheckNotificationPermission,
      isUpdateAvailable: versionStatus == AppVersionStatus.updateAvailable,
      needForceUpdate: versionStatus == AppVersionStatus.needForceUpdate,
      hasRejectUpdateDialog: hasRejectDialog
    );
  }
}