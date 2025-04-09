import 'package:front/features/settings/domain/entities/notification.dart';

abstract interface class NotificationRepository {

  Future<Map<NotificationType, bool>> retrieve();

  Future<void> deactivate(NotificationType notificationType);

  Future<void> activate(NotificationType notificationType);
}