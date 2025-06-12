import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/application_router.dart';

final barlowMobileApp = const ProviderScope(child: BarlowMobileApp());

class BarlowMobileApp extends ConsumerWidget {

  const BarlowMobileApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData(
        chipTheme: const ChipThemeData(
          showCheckmark: false, // ✅ 체크 아이콘 제거
        ),
      ),
      debugShowCheckedModeBanner: true,
      routerConfig: applicationRouter,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        final clampedScale = mediaQuery.textScaler.clamp(
          minScaleFactor: 1.0,
          maxScaleFactor: 1.2,
        );
        return MediaQuery(
          data: mediaQuery.copyWith(
              textScaler: clampedScale, // os 설정에서 글자 크기 무시
              boldText: false // os 설정에서 글자 굵기 무시
          ),
          child: child!,
        );
      },
    );
  }
}
