enum AppVersionStatus {
  latest,
  needForceUpdate,
  updateAvailable,
  invalid,
  ;
}

class AppUpdateInfo {

  final AppVersionStatus versionStatus;
  final String storeUrl;

  AppUpdateInfo({
    required this.versionStatus,
    required this.storeUrl
  });
}