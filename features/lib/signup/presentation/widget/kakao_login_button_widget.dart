import 'package:design_system/kakao_assets.dart';
import 'package:flutter/material.dart';

/// 카카오 로그인 버튼 위젯.
///
/// viewmodel에 의존하지 않으며 [onPressed] 콜백만으로 동작한다.
class KakaoLoginButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const KakaoLoginButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        KakaoAssets.loginLargeWide,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
