import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/database/hive_configs.dart';
import 'package:front/core/database/shared-preferences/shared_prefs_application_setting_repository.dart';
import 'package:front/core/navigation/application_router.dart';
import 'package:front/core/utils/device_info_manager.dart';
import 'package:front/dependency/service_locator.dart';

import 'core/notification/fcm_config.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveInitializer.initializeApp();
  // await HiveInitializer.clearBox();
  FcmInitializer(
    plugin: FlutterLocalNotificationsPlugin(),
    onMessageForegroundHandler: (RemoteMessage message) {},
    onMessageBackgroundHandler: (RemoteMessage message) {},
    onMessageTerminatedHandler: (RemoteMessage message) {},
  ).initialize();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  await getIt<AppSettingsRepository>().clear();
  print("TOKEN : $fcmToken");
  await DeviceInfoManager().init();
  runApp(
    const ProviderScope(
      child: MyApp(),
      )
  );
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
