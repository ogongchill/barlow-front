import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/features/shared/view/error.dart';
import 'package:front/features/splash/presentation/viewmodel/splash_viewmodel.dart';

class SplashView extends ConsumerWidget {

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

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
        error: (err, stack) => const SomethingWentWrongWidget(),
        loading: () => const Text("")
    );
  }
}
