import 'package:design_system/imgs/onboarding_imgs.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/splash/presentation/viewmodel/nickname_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerStatefulWidget {

  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {

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
    _OnboardingData(
      imagePath: OnboardingImages.page1.path,
    ),
    _OnboardingData(
      imagePath: OnboardingImages.page2.path,
    ),
    _OnboardingData(
      imagePath: OnboardingImages.page3.path,
      isLast: true,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    final randomNickname = ref.watch(nicknameProvider).value ?? "바로_사용자";
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (i) {
                  setState(() => _page = i);
                  FocusScope.of(context).unfocus();
              },
              itemBuilder: (context, index) {
                final page = pages[index];
                return Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Center(child: Image.asset(page.imagePath)),
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
                                    _createSignUpButton(() {
                                      ApplicationNavigatorService.goToAuthEntry();
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
        LengthLimitingTextInputFormatter(10),
      ],
      autofocus: false,
      controller: _textEditingController,
      cursorColor: ColorPalette.bluePrimary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: _hintStyle,
        filled: true,
        fillColor: ColorPalette.greyLight,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorPalette.greyLight, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorPalette.bluePrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      style: _inputStyle,
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
