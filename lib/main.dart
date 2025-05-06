import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/database/hive_configs.dart';
import 'package:front/core/navigation/application_router.dart';
import 'package:front/core/utils/device_info_manager.dart';
import 'core/notification/fcm_config.dart';
import 'dependency/locator_dev.dart' as dev;
import 'dependency/locator_prod.dart' as prod;

const _flavor = String.fromEnvironment('FLAVOR');

void main() async {
  _assertFlavor();
  bool clearHive = false;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (_flavor == 'prod') {
    await prod.setUpProdLocator();
  } else if(_flavor == 'prod:clearHive') {
    clearHive = true;
  }else {
    await dev.setUpDevLocator();
  }
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await HiveInitializer.initializeApp();
  if(clearHive) {
    HiveInitializer.clearBox();
  }
  FcmInitializer(
    plugin: FlutterLocalNotificationsPlugin(),
    onMessageForegroundHandler: (RemoteMessage message) {},
    onMessageBackgroundHandler: (RemoteMessage message) {},
    onMessageTerminatedHandler: (RemoteMessage message) {},
  ).initialize();
  await DeviceInfoManager().init();
  FlutterNativeSplash.remove();
  runApp(
    const ProviderScope(
      child: MyApp(),
      )
  );
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

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData(
        chipTheme: const ChipThemeData(
        showCheckmark: false, // ✅ 체크 아이콘 제거
      ),
    ),
      debugShowCheckedModeBanner: true,
      routerConfig: applicationRouter, // ✅ GoRouter 적용
    );
  }
}
