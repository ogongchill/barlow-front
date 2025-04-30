import 'package:front/core/database/notification/notification_read_status_hive_service.dart';
import 'package:front/core/database/user/user_info_hive_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'notification/notification_read_status_hive_entity.dart';

class HiveBoxes {

  static Box<NotificationReadStatusHiveEntity>? _notificationReadStatusBox;
  static Box<UserInfoHiveEntity>? _userInfoBox;

  static Future<void> init() async {
    _notificationReadStatusBox = await Hive.openBox<NotificationReadStatusHiveEntity>('notificationReadStatusBox');
    _userInfoBox = await Hive.openBox<UserInfoHiveEntity>('userInfoHiveBox');
  }

  static Box<NotificationReadStatusHiveEntity> get notificationReadStatusBox => _notificationReadStatusBox!;

  static Box<UserInfoHiveEntity> get userInfoBox => _userInfoBox!;
}

class HiveInitializer {

  static Future<void> initializeApp() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NotificationReadStatusHiveEntityAdapter());
    Hive.registerAdapter(UserInfoHiveEntityAdapter());
    await HiveBoxes.init();
    NotificationReadStatusService.clean();
  }

  // for dev only
  static Future<void> clearBox() async {
    final box = HiveBoxes.notificationReadStatusBox;
    await box.clear();
    final userBox = HiveBoxes.userInfoBox;
    await userBox.clear();
  }
}