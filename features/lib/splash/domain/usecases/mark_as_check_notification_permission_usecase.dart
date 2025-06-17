import 'package:core/storage/shared-preferences/shared_prefs_system_permission_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkAsCheckNotificationPermissionUseCase {

  final PermissionCheckStatusRepository _repository;

  MarkAsCheckNotificationPermissionUseCase({required PermissionCheckStatusRepository repository}): _repository = repository;

  Future<void> execute() async {
    await _repository.markAsChecked(PermissionType.notification);
  }
}