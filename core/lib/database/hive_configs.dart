// import 'package:front/core/database/notification/notification_read_status_hive_service.dart';
// import 'package:front/core/database/setting/user_reject_hive_entity.dart';
// import 'package:front/core/database/user/user_info_hive_entity.dart';
import 'package:core/database/notification/notification_read_status_hive_service.dart';
import 'package:core/database/setting/user_reject_hive_entity.dart';
import 'package:core/database/user/user_info_hive_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'notification/notification_read_status_hive_entity.dart';

class HiveBoxes {

  static Box<NotificationReadStatusHiveEntity>? _notificationReadStatusBox;
  static Box<UserInfoHiveEntity>? _userInfoBox;
  static Box<UserRejectHiveEntity>? _userRejectBox;

  static Future<void> init() async {
    _notificationReadStatusBox = await Hive.openBox<NotificationReadStatusHiveEntity>('notificationReadStatusBox');
    _userInfoBox = await Hive.openBox<UserInfoHiveEntity>('userInfoHiveBox');
    _userRejectBox = await Hive.openBox<UserRejectHiveEntity>('userRejectHiveBox');
  }

  static Box<NotificationReadStatusHiveEntity> get notificationReadStatusBox => _notificationReadStatusBox!;

  static Box<UserInfoHiveEntity> get userInfoBox => _userInfoBox!;

  static Box<UserRejectHiveEntity> get userRejectBox => _userRejectBox!;

}

class HiveInitializer {

  static Future<void> initializeApp() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NotificationReadStatusHiveEntityAdapter());
    Hive.registerAdapter(UserInfoHiveEntityAdapter());
    Hive.registerAdapter(UserRejectHiveEntityAdapter());
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