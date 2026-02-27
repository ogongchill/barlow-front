import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/signup/presentation/util/error_dialog.dart';
import 'package:features/signup/presentation/view/signup_view.dart';
import 'package:features/signup/presentation/viewmodel/signup_notifier.dart';
import 'package:features/signup/presentation/viewmodel/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignupState>(signupProvider, (previous, next) {
      if (next is SignupTermsReady) {
        ApplicationNavigatorService.pushToSignupTerms(
          option: next.option,
          terms: next.terms,
          nickname: '',
        );
        ref.read(signupProvider.notifier).resetToIdle();
      } else if (next is SignupError) {
        _handleSignupError(context, ref, next);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SignupView(nickname: '',),
              const SizedBox(height: 12),
              _GuestButton(
                onPressed: () => ref.read(signupProvider.notifier).startGuestSignup(nickname: ''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignupError(
    BuildContext context,
    WidgetRef ref,
    SignupError error,
  ) async {
    await showSignupErrorDialog(
        context: context,
        title: "오류",
        message: error.message,
        onPressed: () => Navigator.of(context).pop());
    ref.read(signupProvider.notifier).resetToIdle();
    // SignupScreen은 이미 초기 화면 — 별도 이동 없음
  }
}

class _GuestButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _GuestButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: const Text('게스트로 시작하기'),
    );
  }
}
