import 'package:shared_preferences/shared_preferences.dart';

enum PermissionType {

  notification("has_check_notification_permission"),
  ;

  final String key;

  const PermissionType(this.key);
}

  abstract interface class PermissionCheckStatusRepository {

  Future<bool> hasCheck(PermissionType permissionType);
  Future<void> markAsChecked(PermissionType permissionType);
  Future<void> markAsUnchecked(PermissionType permissionType);
}

class SharedPrefsPermissionCheckStatusRepository implements PermissionCheckStatusRepository {

  @override
  Future<bool> hasCheck(PermissionType permissionType) async {
    print("[DEBUG]: hasCheck ${permissionType}");
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(permissionType.key) ?? false;
  }

  @override
  Future<void> markAsChecked(PermissionType permissionType) async {
    print("[DEBUG]: markAsChecked ${permissionType}");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(permissionType.key, true);
  }

  @override
  Future<void> markAsUnchecked(PermissionType permissionType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(permissionType.key, false);
  }
}