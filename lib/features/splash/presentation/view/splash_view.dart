import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/features/splash/presentation/view/splash_screen_widget.dart';
import 'package:front/features/splash/presentation/viewmodel/splash_viewmodel.dart';

class SplashView extends ConsumerWidget {

  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appInitializeInfoProvider, (prev, next) {
      next.whenData((info) {
        if (!info.hasCheckNotificationPermission) {
          ApplicationNavigatorService.goToPermissions();
        } else if (info.isFirstLaunch || !info.isLoggedIn) {
          ApplicationNavigatorService.goToOnBoarding();
        } else {
          ApplicationNavigatorService.goToHome();
        }
      });
    });
    return const SplashScreenWidget();
  }
}
