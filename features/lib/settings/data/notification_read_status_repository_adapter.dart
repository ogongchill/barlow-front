import 'package:core/storage/hive/notification/notification_read_status_hive_service.dart';
import 'package:features/home/domain/repositories/read_status_repository.dart';
import 'package:injectable/injectable.dart';

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