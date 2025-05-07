import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/shared/view/error.dart';
import 'package:front/features/splash/presentation/viewmodel/nickname_provider.dart';
import 'package:front/features/splash/presentation/viewmodel/splash_viewmodel.dart';

class OnboardingView extends ConsumerStatefulWidget {

  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingView> {

  static const _description = TextStyle(
      fontFamily: 'gmarketSans',
      fontWeight: FontWeight.w500,
      color: ColorPalette.greyDark,
      fontSize: 20
  );
  static const _hintStyle = TextStyle(
    fontFamily: 'gmarketSans',
    fontWeight: FontWeight.w300,
    color: ColorPalette.greyDark
  );
  static const _inputStyle = TextStyle(
      fontFamily: 'gmarketSans',
      fontWeight: FontWeight.w500,
      color: ColorPalette.borderBlack
  );

  final PageController _controller = PageController();
  final TextEditingController _textEditingController = TextEditingController();
  int _page = 0;

  final List<_OnboardingData> pages = [
    const _OnboardingData(
      imagePath: 'assets/pictures/onboarding_page_1.png',
    ),
    const _OnboardingData(
      imagePath: 'assets/pictures/onboarding_page_2.png',
    ),
    const _OnboardingData(
      imagePath: 'assets/pictures/onboarding_page_3.png',
      isLast: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final randomNickname = ref.watch(nicknameProvider).value ?? "바로_사용자";

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // 👈 화면 아무 데나 탭하면 포커스 해제
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (i) {
                  setState(() => _page = i);
                  FocusScope.of(context).unfocus(); // 👈 슬라이드 시 포커스 해제
              },
              itemBuilder: (context, index) {
                final page = pages[index];
                return Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Image.asset(page.imagePath),
                      if (page.isLast) ...[
                        Center(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                const SizedBox(height: 100),
                                Row(
                                  children: [
                                    const Text("별명을 정해주세요", style: _description,),
                                    IconButton(onPressed: () => ref.invalidate(nicknameProvider), icon: const Icon(Icons.refresh_rounded, color: ColorPalette.greyDark,)),
                                  ],
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Flexible(child: _createTextField(randomNickname)),
                                    _createSignUpButton(() async {
                                      String nickname = _textEditingController.text.isEmpty
                                          ? randomNickname
                                          : _textEditingController.text;
                                      try {
                                        await ref.read(signupUseCaseProvider(nickname).future);
                                        ApplicationNavigatorService.goToHome();
                                      } catch (_) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => const SomethingWentWrongWidget(),
                                        );
                                      }
                                    },)
                                  ],
                                ),
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
              top: 60,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                      (i) => Container(
                    margin: const EdgeInsets.all(4),
                    width: 8,
                    height: 8,
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
      ),
    );
  }

  Widget _createTextField(String hintText) {
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(10), // 👈 최대 10자 제한
      ],
      autofocus: false,
      controller: _textEditingController,
      cursorColor: ColorPalette.bluePrimary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: _hintStyle,           // 힌트 글자색
        filled: true,
        fillColor: ColorPalette.greyLight, // 배경색
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorPalette.greyLight, width: 0), // 포커스 시 테두리
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorPalette.bluePrimary, width: 2), // 포커스 시 테두리
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // 내부 여백
      ),
      style: _inputStyle, // 입력 글자 색
    );
  }
  
  Widget _createSignUpButton(Function onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: ColorPalette.blueDeep,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            '(으)로 시작',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String imagePath;
  final bool isLast;

  const _OnboardingData({
    required this.imagePath,
    this.isLast = false,
  });
}
