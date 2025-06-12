// import 'package:front/features/settings/domain/entities/notification.dart';
// import 'package:front/features/settings/domain/repositories/notification_repository.dart';

import 'package:features/settings/domain/entities/notification.dart';
import 'package:features/settings/domain/repositories/notification_repository.dart';

class ChangeNotificationUseCase {

  final NotificationRepository _repository;

  ChangeNotificationUseCase({required NotificationRepository repository}): _repository = repository;

  void deactivate(NotificationType notificationType) {
    _repository.deactivate(notificationType);
  }

  void activate(NotificationType notificationType) {
    _repository.activate(notificationType);
  }
}

class FetchNotificationUseCase {

  final NotificationRepository _repository;

  FetchNotificationUseCase({required NotificationRepository repository}): _repository = repository;

  Future<Map<NotificationType, bool>> execute() {
    return _repository.retrieve();
  }
}