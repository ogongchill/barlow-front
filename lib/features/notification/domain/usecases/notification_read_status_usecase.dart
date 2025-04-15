import 'package:front/features/notification/domain/repositories/read_status_repository.dart';

class MarkAsReadNotificationUseCase {

  final ReadStatusRepository _repository;

  MarkAsReadNotificationUseCase({required ReadStatusRepository repository}): _repository = repository;

  Future<void> execute(String id) async {
    _repository.markAsRead(id);
  }
}

class CheckIsReadNotificationUseCase {

  final ReadStatusRepository _repository;

  CheckIsReadNotificationUseCase({required ReadStatusRepository repository}): _repository = repository;

  Future<bool> execute(String id) async {
    return _repository.isRead(id);
  }
}