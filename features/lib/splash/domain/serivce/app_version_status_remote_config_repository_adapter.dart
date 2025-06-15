import 'package:core/notification/firebase_manager.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:features/splash/domain/entities/app_version_status.dart';
import 'package:features/splash/domain/repositories/app_version_status_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:pub_semver/pub_semver.dart';

@injectable
class VersionCheckRemoteConfigService {

  final DeviceInfo _deviceInfoInfo;
  final RemoteConfigManager _remoteConfigManager;

  VersionCheckRemoteConfigService(this._deviceInfoInfo,
      this._remoteConfigManager);

  AppVersionStatus checkAppVersion() {
    if(_remoteConfigManager.needForceUpdate() == true) {
      return AppVersionStatus.needForceUpdate;
    }
    final current = Version.parse(_deviceInfoInfo.appVersion) ;
    final latest = Version.parse(_remoteConfigManager.readLatestVersion());
    final minimum = Version.parse(_remoteConfigManager.readMinimumVersion());
    if(current < minimum) {
      return AppVersionStatus.needForceUpdate;
    }
    if(current < latest) {
      return AppVersionStatus.updateAvailable;
    }
    return AppVersionStatus.latest;
  }
}

@LazySingleton(as: AppVersionStatusRepository)
class AppVersionStatusRemoteConfigRepositoryAdapter implements AppVersionStatusRepository {

  final VersionCheckRemoteConfigService _service;

  AppVersionStatusRemoteConfigRepositoryAdapter({required VersionCheckRemoteConfigService versionCheckRemoteConfigService}): _service = versionCheckRemoteConfigService;

  @override
  Future<AppVersionStatus> fetchVersionInfo() async {
    return _service.checkAppVersion();
  }
}