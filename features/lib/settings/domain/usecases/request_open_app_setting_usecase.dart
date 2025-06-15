import 'package:permission_handler/permission_handler.dart';

class RequestOpenAppSettingUseCase {

  RequestOpenAppSettingUseCase();

  Future<void> execute() async{
    await openAppSettings();
  }
}