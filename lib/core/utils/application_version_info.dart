import 'package:package_info_plus/package_info_plus.dart';

abstract interface class ApplicationVersionInfo {

  String get appName;
  String get packageName;
  String get version;
  String get buildNumber;
}

class ApplicationVersionInfoManager implements ApplicationVersionInfo{

  final PackageInfo _packageInfo;

  ApplicationVersionInfoManager._(this._packageInfo);

  static Future<ApplicationVersionInfoManager> init() async {
    final info = await PackageInfo.fromPlatform();
    return ApplicationVersionInfoManager._(info);
  }

  @override
  String get appName => _packageInfo.appName;

  @override
  String get buildNumber => _packageInfo.buildNumber;

  @override
  String get packageName => _packageInfo.packageName;

  @override
  String get version => _packageInfo.version;
}
