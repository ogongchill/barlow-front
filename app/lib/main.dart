import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:core/notification/fcm_config.dart';
import 'package:features/barlow_app.dart';
import 'package:core/storage/hive/hive_configs.dart';
import 'package:core/notification/firebase_remote_config_initializer.dart';

import 'di.dart';

const _flavor = String.fromEnvironment('FLAVOR');

void main() async {
  _assertFlavor();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveInitializer.initializeApp();
  if(_flavor == 'prod:clearHive') {
    HiveInitializer.clearBox();
    configureDependencies('prod');
  } else {
    configureDependencies(_flavor);
  }
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FcmInitializer(
    plugin: FlutterLocalNotificationsPlugin(),
    onMessageForegroundHandler: (RemoteMessage message) {},
    onMessageBackgroundHandler: (RemoteMessage message) {},
    onMessageTerminatedHandler: (RemoteMessage message) {},
  ).initialize();
  await FirebaseRemoteConfigInitializer().initialize();
  await DeviceInfoManager().init();
  FlutterNativeSplash.remove();
  runApp(barlowMobileApp);
}

void _assertFlavor() {
  assert(() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      if (_flavor != 'prod') {
        throw Exception('❌ 릴리즈 빌드는 반드시 FLAVOR=prod 이어야 합니다.');
      }
    }
    return true;
  }());
}