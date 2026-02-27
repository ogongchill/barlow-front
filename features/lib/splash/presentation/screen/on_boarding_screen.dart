import 'package:design_system/imgs/onboarding_imgs.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/signup/presentation/util/error_dialog.dart';
import 'package:features/signup/presentation/viewmodel/signup_notifier.dart';
import 'package:features/signup/presentation/viewmodel/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<_OnboardingData> pages = [
    _OnboardingData(imagePath: OnboardingImages.page1.path),
    _OnboardingData(imagePath: OnboardingImages.page2.path),
    _OnboardingData(imagePath: OnboardingImages.page3.path, isLast: true),
  ];

  @override
  Widget build(BuildContext context) {
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

    final signupState = ref.watch(signupProvider);
    final isLoading = signupState is SignupLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (i) { setState(() => _page = i); },
            itemBuilder: (context, index) {
              final page = pages[index];
              return Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Center(child: Image.asset(page.imagePath)),
                    if (page.isLast) ...[
                      Positioned(
                        left: 0, right: 0, bottom: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 12,
                            children: [
                              _KakaoButton(
                                isLoading: isLoading,
                                onPressed: isLoading ? null : () => ref.read(signupProvider.notifier).startKakaoSignup(nickname: ''),
                              ),
                              _GuestButton(
                                isLoading: isLoading,
                                onPressed: isLoading ? null : () => ref.read(signupProvider.notifier).startGuestSignup(nickname: ''),
                              ),
                              _HasAccountLink(isLoading: isLoading),
                            ],
                          ),
                        ),
                      ),
                    ] else
                      const SizedBox(height: 80),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 60, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => Container(
                  margin: const EdgeInsets.all(4),
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _page == i ? ColorPalette.bluePrimary : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignupError(BuildContext context, WidgetRef ref, SignupError error) async {
    await showSignupErrorDialog(
      context: context,
      title: '오류',
      message: error.message,
      onPressed: () => Navigator.of(context).pop(),
    );
    ref.read(signupProvider.notifier).resetToIdle();
  }
}

class _KakaoButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  const _KakaoButton({required this.isLoading, required this.onPressed});
  static const _kakaoYellow = Color(0xFFFEE500);
  static const _kakaoLabel = Color(0xFF191919);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _kakaoYellow,
        foregroundColor: _kakaoLabel,
        disabledBackgroundColor: _kakaoYellow.withValues(alpha: 0.6),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: isLoading
          ? const SizedBox(
              width: 22, height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(_kakaoLabel),
              ),
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(Icons.chat_bubble_rounded, size: 20),
                Text(
                  '카카오로 시작하기',
                  style: TextStyle(fontFamily: 'gmarketSans', fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
    );
  }
}

class _GuestButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  const _GuestButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: ColorPalette.greyDark),
        foregroundColor: ColorPalette.greyDark,
      ),
      child: const Text(
        '게스트로 시작하기',
        style: TextStyle(fontFamily: 'gmarketSans', fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}

class _HasAccountLink extends StatelessWidget {
  final bool isLoading;
  const _HasAccountLink({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : ApplicationNavigatorService.pushToLogin,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          '계정이 있습니다',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'gmarketSans',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: isLoading ? ColorPalette.greyDark.withValues(alpha: 0.4) : ColorPalette.greyDark,
            decoration: TextDecoration.underline,
            decorationColor: isLoading ? ColorPalette.greyDark.withValues(alpha: 0.4) : ColorPalette.greyDark,
          ),
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String imagePath;
  final bool isLast;
  const _OnboardingData({required this.imagePath, this.isLast = false});
}
