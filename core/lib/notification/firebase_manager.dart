import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FcmManager {

  final FirebaseMessaging _firebaseMessaging;

  FcmManager(this._firebaseMessaging);

  Future<void> deleteToken() async {
    _firebaseMessaging.deleteToken();
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}

@LazySingleton()
class RemoteConfigManager{

  final FirebaseRemoteConfig _firebaseRemoteConfig;

  RemoteConfigManager(this._firebaseRemoteConfig);

  String readMinimumVersion() => _firebaseRemoteConfig.getString("minimumSupported");

  String readLatestVersion() => _firebaseRemoteConfig.getString("latest");

  bool needForceUpdate() => _firebaseRemoteConfig.getBool("forceUpdate");

  String readAppstoreUrl() => _firebaseRemoteConfig.getString("appStoreUrl");

  String readPlayStoreUrl() => _firebaseRemoteConfig.getString("androidStoreUrl");

  bool isServerUnderMaintenance() => _firebaseRemoteConfig.getBool("isServerUnderMaintenance");
}