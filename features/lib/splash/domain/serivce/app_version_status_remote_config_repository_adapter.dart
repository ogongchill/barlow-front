import 'package:core/utils/device_info_manager.dart';
import 'package:features/splash/domain/entities/app_version_status.dart';
import 'package:features/splash/domain/repositories/app_version_status_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:pub_semver/pub_semver.dart';

class VersionCheckRemoteConfig {

  final FirebaseRemoteConfig _remoteConfig;

  VersionCheckRemoteConfig._(this._remoteConfig);

  static Future<VersionCheckRemoteConfig> init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(minutes: 5),
    ));

    await remoteConfig.fetchAndActivate();

    return VersionCheckRemoteConfig._(remoteConfig);
  }

  String get minimumVersion => _remoteConfig.getString("minimumSupported");
  String get latestVersion => _remoteConfig.getString("latest");
  bool get forceUpdateStatus => _remoteConfig.getBool("forceUpdate");
}

class VersionCheckRemoteConfigService {

  final VersionCheckRemoteConfig _remoteConfig;
  final DeviceInfo _deviceInfoInfo;

  VersionCheckRemoteConfigService({required VersionCheckRemoteConfig versionCheckRemoteConfig, required DeviceInfo deviceInfo})
      : _remoteConfig = versionCheckRemoteConfig, _deviceInfoInfo = deviceInfo;

  AppVersionStatus checkAppVersion() {
    if(_remoteConfig.forceUpdateStatus == true) {
      return AppVersionStatus.needForceUpdate;
    }
    final current = Version.parse(_deviceInfoInfo.appVersion) ;
    final latest = Version.parse(_remoteConfig.latestVersion);
    final minimum = Version.parse(_remoteConfig.minimumVersion);
    if(current < minimum) {
      return AppVersionStatus.needForceUpdate;
    }
    if(current < latest) {
      return AppVersionStatus.updateAvailable;
    }
    return AppVersionStatus.latest;
  }
}

class AppVersionStatusRemoteConfigRepositoryAdapter implements AppVersionStatusRepository {

  final VersionCheckRemoteConfigService _service;

  AppVersionStatusRemoteConfigRepositoryAdapter({required VersionCheckRemoteConfigService versionCheckRemoteConfigService}): _service = versionCheckRemoteConfigService;

  @override
  Future<AppVersionStatus> fetchVersionInfo() async {
    return _service.checkAppVersion();
  }
}