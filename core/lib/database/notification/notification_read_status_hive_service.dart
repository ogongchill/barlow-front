// import 'package:front/core/database/notification/notification_read_status_hive_entity.dart';
// import 'package:front/core/database/hive_configs.dart';

import 'package:core/database/hive_configs.dart' show HiveBoxes;
import 'package:core/database/notification/notification_read_status_hive_entity.dart';

class NotificationReadStatusService {

  static const Duration _ttl = Duration(days: 7);
  static final _box = HiveBoxes.notificationReadStatusBox;

  static void markAsRead(String billId) async {
    _box.put(billId, NotificationReadStatusHiveEntity(billId: billId, receivedAt: DateTime.now(), isRead: true));
  }

  static void clean() async {
    DateTime now = DateTime.now();
    DateTime sevenDaysAgo = now.subtract(_ttl);
    final expired = _box.values
        .where((entity) => entity.receivedAt.isBefore(sevenDaysAgo))
        .toList();

    await Future.wait(expired.map((entity) => entity.delete()));
  }

  static bool isRead(String billId) {
    NotificationReadStatusHiveEntity? entity = _box.get(billId);
    if(entity == null) {
      return false;
    }
    return entity.isRead;
  }
}