import 'package:front/core/database/shared-preferences/shared_prefs_system_permission_repository.dart';

class MarkAsCheckNotificationPermissionUseCase {

  final PermissionCheckStatusRepository _repository;

  MarkAsCheckNotificationPermissionUseCase({required PermissionCheckStatusRepository repository}): _repository = repository;

  Future<void> execute() async {
    await _repository.markAsChecked(PermissionType.notification);
  }
}