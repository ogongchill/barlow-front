import 'package:core/storage/shared-preferences/shared_prefs_read_status_service.dart';
import 'package:features/home/domain/repositories/read_status_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReadStatusRepository)
class NotificationReadStatusRepositoryAdapter implements ReadStatusRepository {

  @override
  Future<bool> isRead(String billId) async {
    return SharedPrefsReadStatusService.isRead(billId);
  }

  @override
  Future<void> markAsRead(String billId) async {
    await SharedPrefsReadStatusService.markAsRead(billId);
  }
}
