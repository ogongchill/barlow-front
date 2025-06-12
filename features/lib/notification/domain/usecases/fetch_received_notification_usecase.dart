import 'package:features/notification/domain/entities/received_notificaton.dart';
import 'package:features/notification/domain/repositories/received_notification_repository.dart';

class FetchReceivedNotificationUseCase {

  final ReceivedNotificationRepository _repository;

  FetchReceivedNotificationUseCase({required ReceivedNotificationRepository repository}): _repository = repository;

  Future<List<ReceivedNotification>> execute() {
    return _repository.retrieveAll();
  }
}