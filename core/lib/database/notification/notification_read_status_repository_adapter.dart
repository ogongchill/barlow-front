import 'package:features/notification/domain/repositories/read_status_repository.dart';
// import 'package:front/core/database/notification/notification_read_status_hive_service.dart';
// import 'package:front/features/notification/domain/repositories/read_status_repository.dart';
import 'notification_read_status_hive_service.dart';

class NotificationReadStatusRepositoryAdapter implements ReadStatusRepository {

  @override
  Future<bool> isRead(String billId) async {
    return NotificationReadStatusService.isRead(billId);
  }

  @override
  Future<void> markAsRead(String billId) async {
    NotificationReadStatusService.markAsRead(billId);
  }
}