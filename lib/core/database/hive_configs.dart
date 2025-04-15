import 'package:front/core/database/notification/notification_read_status_hive_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'notification/notification_read_status_hive_entity.dart';

class HiveBoxes {

  static Box<NotificationReadStatusHiveEntity>? _notificationReadStatusBox;

  static Future<void> init() async {
    _notificationReadStatusBox = await Hive.openBox<NotificationReadStatusHiveEntity>('notificationReadStatusBox');
  }

  static Box<NotificationReadStatusHiveEntity> get notificationReadStatusBox => _notificationReadStatusBox!;
}

class HiveInitializer {

  static Future<void> initializeApp() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NotificationReadStatusHiveEntityAdapter());
    await HiveBoxes.init();
    NotificationReadStatusService.clean();
  }

  // for dev only
  static Future<void> clearBox() async {
    final box = HiveBoxes.notificationReadStatusBox;
    await box.clear();
  }
}