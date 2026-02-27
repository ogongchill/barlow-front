import 'package:features/signup/presentation/viewmodel/signup_notifier.dart';
import 'package:features/signup/presentation/viewmodel/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 카카오 로그인 버튼 위젯.
///
/// [signupProvider] 상태를 구독하여:
/// - [SignupLoading] 상태이면 버튼을 비활성화하고 [CircularProgressIndicator]를 표시한다.
/// - 그 외 상태이면 '카카오 로그인' 텍스트와 함께 버튼을 활성화한다.
class LoginButtonWidget extends ConsumerWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupProvider);
    final isLoading = state is SignupLoading;

    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () =>
              ref.read(signupProvider.notifier).startKakaoSignup(),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('카카오 로그인'),
    );
  }
}
