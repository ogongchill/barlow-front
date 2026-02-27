import 'package:design_system/theme/color_palette.dart';
import 'package:features/signup/presentation/widget/kakao_login_button_widget.dart';
import 'package:features/signup/presentation/viewmodel/login_option.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const List<LoginOption> _options = [
    KakaoLoginOption(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: ColorPalette.greyDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '로그인',
                style: TextStyle(
                  fontFamily: 'gmarketSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: ColorPalette.greyDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '계정으로 로그인하세요.',
                style: TextStyle(
                  fontFamily: 'gmarketSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorPalette.greyDark,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _options.map(_buildOptionButton).toList(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(LoginOption option) {
    return switch (option) {
      KakaoLoginOption() => KakaoLoginButtonWidget(
          onPressed: () {},
        ),
    };
  }
}
