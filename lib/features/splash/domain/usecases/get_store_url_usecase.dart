import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:front/core/utils/device_info_manager.dart';

class GetStoreUrlUseCase {

  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final DeviceInfo _deviceInfo;
  final String _playStoreUrl;
  final String _appStoreUrl;

  GetStoreUrlUseCase({required DeviceInfo deviceInfo})
    : _deviceInfo = deviceInfo,
      _playStoreUrl = _remoteConfig.getString("androidStoreUrl"),
      _appStoreUrl = _remoteConfig.getString("appStoreUrl");

  String execute() {
    if(_deviceInfo.deviceOs == "android") {
      return _playStoreUrl;
    }
    if(_deviceInfo.deviceOs == "ios") {
      return _appStoreUrl;
    }
    return "https://ogongchill.github.io";
  }
}