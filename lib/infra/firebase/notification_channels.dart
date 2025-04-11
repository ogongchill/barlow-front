import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmChannelConfig {

  static const AndroidNotificationChannel committeeNotificationChannelAndroid = AndroidNotificationChannel(
    "committee_notification_channel",
    "상임위원회 법안 알림",
    description: "소관 상임위원회에 등록된 법안 알림입니다.",
    importance: Importance.high,
  );

  static const AndroidNotificationDetails committeeNotificationDetail = AndroidNotificationDetails(
    "committee_notification_channel",
    "상임위원회 법안 알림",
    channelDescription: "소관 상임위원회에 등록된 법안 알림입니다.",
    icon: '@mipmap/ic_launcher',
    importance: Importance.max,
    priority: Priority.high,
  );
}