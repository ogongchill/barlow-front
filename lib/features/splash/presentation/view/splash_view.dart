import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/features/shared/view/error.dart';
import 'package:front/features/splash/presentation/viewmodel/splash_viewmodel.dart';

class SplashView extends ConsumerWidget {

  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(appInitializeInfoProvider);
    return asyncValue.when(
        data: (info) {
          Future.microtask(() {
            if (info.isFirstLaunch) {
              ApplicationNavigatorService.goToOnBoarding();
            } else if (!info.isLoggedIn) {
              ref.read(loginUseCaseProvider);
              ApplicationNavigatorService.goToHome();
            } else {
              ApplicationNavigatorService.goToHome();
            }
          });
          return _getSplashView();
        },
        error: (err, stack) => const SomethingWentWrongWidget(),
        loading: () => _getSplashView()
    );
  }

  /// android 12 + 설정 (splash 아이콘 크기 288 x 288dp)
  /// ios 및 android 11 이하 버전 확인 필요
  Scaffold _getSplashView() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/pictures/splash_android_12_바로.png',
          width: 288,
          height: 288,
        ),
      ),
    );
  }

}
