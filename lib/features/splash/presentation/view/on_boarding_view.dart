import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/features/shared/view/error.dart';
import 'package:front/features/splash/presentation/viewmodel/splash_viewmodel.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                '환영합니다!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                '이 앱은 국회의 입법 정보를 쉽고 빠르게 확인할 수 있도록 도와줍니다.\n\n간단한 가입만으로 알림, 즐겨찾기 등의 기능을 사용할 수 있어요!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await ref.read(signupUseCaseProvider("기본 이름").future);
                    ApplicationNavigatorService.goToHome();
                  } catch (e) {
                    print(e);
                    showDialog(
                      context: context,
                      builder: (_) => const SomethingWentWrongWidget(),
                    );
                  }
                },
                child: const Text('시작하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
