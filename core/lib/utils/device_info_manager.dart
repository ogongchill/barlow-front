import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract interface class DeviceInfo {

  String get deviceOs;
  String get deviceOsVersion;
  String get deviceId;
  String get appVersion;
}

@LazySingleton(as: DeviceInfo)
class DeviceInfoManager implements DeviceInfo{

  static final DeviceInfoManager _instance = DeviceInfoManager._internal();

  factory DeviceInfoManager() => _instance;
  DeviceInfoManager._internal();

  @override
  late final String deviceOs;
  @override
  late final String deviceOsVersion;
  @override
  late final String deviceId;
  @override
  late final String appVersion;

  Future<void> init() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      deviceOs = 'android';
      deviceOsVersion = 'Android ${android.version.release}';
      deviceId = android.id ?? 'unknown';
      return;
    }

    if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      deviceOs = 'ios';
      deviceOsVersion = 'iOS ${ios.systemVersion}';
      deviceId = ios.identifierForVendor ?? 'unknown';
      return;
    }

    deviceOs = 'unknown';
    deviceOsVersion = 'unknown';
    deviceId = 'unknown';
  }
}
