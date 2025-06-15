import 'package:core/database/secure-storage/token_repository.dart';
import 'package:core/database/shared-preferences/shared_prefs_application_setting_repository.dart';
import 'package:core/database/shared-preferences/shared_prefs_system_permission_repository.dart';
import 'package:features/splash/domain/entities/app_initialize_info.dart';
import 'package:features/splash/domain/repositories/app_initialize_info_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppInitializeInfoRepository)
class AppInitializeInfoRepositoryAdapter implements AppInitializeInfoRepository {

  final AppSettingsRepository _appSettingsRepository;
  final PermissionCheckStatusRepository _systemPermissionRepository;
  final TokenRepository _tokenRepository;

  AppInitializeInfoRepositoryAdapter(this._appSettingsRepository, this._systemPermissionRepository, this._tokenRepository);

  @override
  Future<AppInitializeInfo> retrieve() async {
    bool isFirstLaunch = await _appSettingsRepository.isFirstLaunch();
    bool isLoggedIn = await _tokenRepository.readAccessToken() != null;
    bool hasCheckNotificationPermission = await _systemPermissionRepository.hasCheck(PermissionType.notification);
    return AppInitializeInfo(isFirstLaunch: isFirstLaunch, isLoggedIn: isLoggedIn, hasCheckNotificationPermission: hasCheckNotificationPermission);
  }
}