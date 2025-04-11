import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:front/infra/firebase/notification_channels.dart';

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
  // @pragma('vm:entry-point')
  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   print('🔙 백그라운드 메시지 수신: ${message.messageId}');
  // }
}


