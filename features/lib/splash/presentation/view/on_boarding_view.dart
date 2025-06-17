import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/text_style_preset.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/shared/presentation/widget/error.dart';
import 'package:features/splash/presentation/viewmodel/nickname_provider.dart';
import 'package:features/splash/presentation/viewmodel/splash_viewmodel.dart';
import 'package:features/splash/presentation/viewmodel/terms_and_policies_vewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  static const _agreementStyle = TextStyle(
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
                                    _createSignUpButton(() async {
                                      String nickname = _textEditingController.text.isEmpty
                                          ? randomNickname
                                          : _textEditingController.text;
                                      try {
                                        showTermsAgreementDialog(context, ref, nickname);
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

  Future<void> showTermsAgreementDialog(BuildContext context, WidgetRef ref, String nickname) async {
    bool termsChecked = false;
    bool privacyChecked = false;
    bool allChecked = false;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final termsAgreementViewModel = ref.read(termsAgreementViewModelProvider.notifier);

        return StatefulBuilder(builder: (context, setState) {
          void updateAllChecked() {
            allChecked = termsChecked && privacyChecked;
          }

          Future<void> showWebDialog(BuildContext context, String title, String url) async {
            final controller = WebViewController()..loadRequest(Uri.parse(url));

            await showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return Dialog(
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.white,
                        title: Text(title, style: TextStylePreset.appBarTitle,),
                        automaticallyImplyLeading: false,
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      Expanded(
                        child: WebViewWidget(controller: controller),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return Dialog(
          insetPadding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // 모서리 둥글게
            ),
          backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children :[
                        const Center(child: Text("약관 동의", style: TextStylePreset.appBarTitle)),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ]
                  ),
                ),
                Column(
                  children: [
                    // ✅ 서비스 이용약관 동의
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: termsChecked,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                termsChecked = value ?? false;
                                updateAllChecked();
                              });
                            },
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "서비스 이용약관 동의",
                                    style: _agreementStyle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => showWebDialog(
                                    context,
                                    "서비스 약관",
                                    'https://ogongchill.github.io/barlow/terms-of-service.html',
                                  ),
                                  child: const Text("보기", style: TextStyle(color: Colors.grey)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ✅ 개인정보 처리방침 동의
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: privacyChecked,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                privacyChecked = value ?? false;
                                updateAllChecked();
                              });
                            },
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "개인정보 처리방침 동의",
                                    style: _agreementStyle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => showWebDialog(
                                    context,
                                    "개인정보 처리방침",
                                    'https://ogongchill.github.io/barlow/privacy-policy.html',
                                  ),
                                  child: const Text("보기", style: TextStyle(color: Colors.grey)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ✅ 모두 동의
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: allChecked,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                allChecked = value ?? false;
                                termsChecked = value ?? false;
                                privacyChecked = value ?? false;
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                              "모두 동의",
                              style: _agreementStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: ColorPalette.bluePrimary),
                    onPressed: termsChecked && privacyChecked
                        ? () async {
                      await termsAgreementViewModel.agree();
                      await ref.read(signupUseCaseProvider(nickname).future);
                      if (context.mounted) Navigator.of(context).pop();
                      ApplicationNavigatorService.goToHome();
                    }
                        : null,
                    child: const Text("동의하고 시작하기", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                )
              ],
            ),
          );
        });
      },
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

