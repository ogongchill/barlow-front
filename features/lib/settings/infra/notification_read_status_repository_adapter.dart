import 'package:features/notification/domain/repositories/read_status_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:core/database/notification/notification_read_status_hive_service.dart';
@LazySingleton(as: ReadStatusRepository)
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