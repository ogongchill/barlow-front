import 'package:design_system/theme/color_palette.dart';
import 'package:features/navigation/application_navigation_service.dart';
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
        );
        ref.read(signupProvider.notifier).resetToIdle();
      } else if (next is SignupError) {
        _showErrorSnackBar(context, next.message);
        ref.read(signupProvider.notifier).resetToIdle();
      }
    });

    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SignupView(),
              const SizedBox(height: 12),
              _GuestButton(
                onPressed: () => ref.read(signupProvider.notifier).startGuestSignup(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'gmarketSans', color: Colors.white),
        ),
        backgroundColor: ColorPalette.greyDark,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
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
