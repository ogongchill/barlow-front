import 'package:features/notification/domain/repositories/read_status_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkAsReadNotificationUseCase {

  final ReadStatusRepository _repository;

  MarkAsReadNotificationUseCase({required ReadStatusRepository repository}): _repository = repository;

  Future<void> execute(String id) async {
    _repository.markAsRead(id);
  }
}

@injectable
class CheckIsReadNotificationUseCase {

  final ReadStatusRepository _repository;

  CheckIsReadNotificationUseCase({required ReadStatusRepository repository}): _repository = repository;

  Future<bool> execute(String id) async {
    return _repository.isRead(id);
  }
}