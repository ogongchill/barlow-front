import 'dart:math';

import 'package:features/settings/domain/entities/notification.dart';
import 'package:features/settings/domain/repositories/notification_repository.dart';

class DummyNotificationRepository implements NotificationRepository {

  final Map<NotificationType, bool> _notifications;

  DummyNotificationRepository()
      : _notifications = Map.fromEntries(
      CommitteeNotificationType.getAll()
      .map((committeeNoti) => MapEntry.new(committeeNoti, Random().nextBool())));

  @override
  Future<void> activate(NotificationType notificationType) async {
    print("POST : activate ${notificationType.name}");
    _notifications[notificationType] = true;
    await Future.delayed(const Duration(milliseconds: 500));
    return;
  }

  @override
  Future<void> deactivate(NotificationType notificationType) async{
    print("POST : deactivate ${notificationType.name}");
    await Future.delayed(const Duration(milliseconds: 500));
    _notifications[notificationType] = false;
    return;
  }

  @override
  Future<Map<NotificationType, bool>> retrieve() async {
    print("GET : fetching notifications....");
    await Future.delayed(const Duration(milliseconds: 500));
    return Map.from(_notifications);
  }
}