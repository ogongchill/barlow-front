import 'package:core/notification/firebase_manager.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetStoreUrlUseCase {

  final DeviceInfo _deviceInfo;
  final RemoteConfigManager _remoteConfigManager;

  GetStoreUrlUseCase(this._deviceInfo, this._remoteConfigManager);

  String execute() {
    if(_deviceInfo.deviceOs == "android") {
      return _remoteConfigManager.readPlayStoreUrl();
    }
    if(_deviceInfo.deviceOs == "ios") {
      return _remoteConfigManager.readAppstoreUrl();
    }
    return "https://ogongchill.github.io";
  }
}