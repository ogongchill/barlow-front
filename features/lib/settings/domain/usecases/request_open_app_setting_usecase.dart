import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestOpenAppSettingUseCase {

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  RequestOpenAppSettingUseCase();

  Future<void> execute() async{
    await openAppSettings();
  }
}