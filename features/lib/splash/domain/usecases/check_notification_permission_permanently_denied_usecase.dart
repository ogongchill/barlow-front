import 'package:permission_handler/permission_handler.dart';

enum PermissionStatus{
  denied,
  permanentlyDenied,
  granted
}

class CheckNotificationPermissionStatusUseCase {

  static Future<PermissionStatus> execute() async {
    final result = await Permission.notification.request();
    if(result.isPermanentlyDenied) {
      return PermissionStatus.permanentlyDenied;
    }
    if(result.isGranted) {
      return PermissionStatus.granted;
    }
    return PermissionStatus.denied;
  }
}
