import 'package:front/core/database/shared-preferences/shared_prefs_system_permission_repository.dart';

class DummyPermissionStatusRepository implements PermissionCheckStatusRepository {

  bool _checkStatus = false;

  @override
  Future<bool> hasCheck(PermissionType permissionType) async {
    print("[DEBUG]: hasCheck ${permissionType}");
    return _checkStatus;
  }

  @override
  Future<void> markAsChecked(PermissionType permissionType) async {
    print("[DEBUG]: markAsChecked ${permissionType}");
    _checkStatus = true;
  }

  @override
  Future<void> markAsUnchecked(PermissionType permissionType) async {
    _checkStatus = false;
  }
}