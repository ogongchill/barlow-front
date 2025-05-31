class AppInitializeInfo {

  final bool isFirstLaunch;
  final bool isLoggedIn;
  final bool hasCheckNotificationPermission;

  AppInitializeInfo({
    required this.isFirstLaunch,
    required this.isLoggedIn,
    required this.hasCheckNotificationPermission
 });
}