import 'package:core/notification/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:front/core/notification/firebase_options.dart';

import 'notification_channels.dart';

@pragma('vm:entry-point') // Flutter 3.3.0 이상에서 권장
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리 시작: ${message.messageId}");
  return;
}

class FcmInitializer {

  final FlutterLocalNotificationsPlugin _plugin;
  final Function(RemoteMessage message) _onMessageForegroundHandler;
  final Function(RemoteMessage message) _onMessageBackgroundHandler;
  final Function(RemoteMessage message) _onMessageTerminatedHandler;

  FcmInitializer({
    required FlutterLocalNotificationsPlugin plugin,
    required Function(RemoteMessage message) onMessageForegroundHandler,
    required Function(RemoteMessage message) onMessageBackgroundHandler,
    required Function(RemoteMessage message) onMessageTerminatedHandler
  }) : _plugin = plugin,
      _onMessageTerminatedHandler = onMessageTerminatedHandler,
      _onMessageBackgroundHandler = onMessageBackgroundHandler,
      _onMessageForegroundHandler = onMessageForegroundHandler;

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _initializePlugin();
    await _registerNotificationChannels();
    _setupFcmListeners();
  }

  Future<void> _initializePlugin() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(initSettings);
  }

  Future<void> _registerNotificationChannels() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin == null) return;

    await androidPlugin.createNotificationChannel(FcmChannelConfig.committeeNotificationChannelAndroid);
  }

  void _setupFcmListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📬 Foreground 메시지 수신: ${message.notification?.title}');
      _showNotification(message);
      _onMessageForegroundHandler(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📬 Background에서 메시지 탭하고 앱 열림: ${message.notification?.title}');
      _onMessageBackgroundHandler(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _onMessageTerminatedHandler(message);
        print('📬 앱 종료 상태에서 메시지 탭하고 열림: ${message.notification?.title}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = notification?.android;

    if (notification != null && android != null) {
      await _plugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: FcmChannelConfig.committeeNotificationDetail,
        ),
      );
    }
  }
}
