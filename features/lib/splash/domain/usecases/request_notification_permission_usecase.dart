import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

@injectable
class RequestNotificationPermissionUseCase {

  RequestNotificationPermissionUseCase();

  Future<void> execute() async {
    _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      await _requestAndroidNotificationPermission();
    }
    if (Platform.isIOS) {
      await _requestIosNotificationPermission();
    }
  }

  Future<void> _requestAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
      return;
    }
  }

  Future<void> _requestIosNotificationPermission() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final iosPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

    final result = await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}