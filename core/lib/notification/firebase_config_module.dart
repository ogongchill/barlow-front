import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseConfigModule {

  @LazySingleton()
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @LazySingleton()
  FirebaseRemoteConfig get firebaseRemoteConfig => FirebaseRemoteConfig.instance;
}