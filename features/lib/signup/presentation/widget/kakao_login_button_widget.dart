import 'package:flutter/material.dart';

/// 카카오 로그인 버튼 위젯.
///
/// viewmodel에 의존하지 않으며 [onPressed] 콜백만으로 동작한다.
class KakaoLoginButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const KakaoLoginButtonWidget({super.key, required this.onPressed});

  static const _kakaoYellow = Color(0xFFFEE500);
  static const _kakaoLabel = Color(0xFF191919);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _kakaoYellow,
        foregroundColor: _kakaoLabel,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_rounded, size: 20),
          SizedBox(width: 8),
          Text(
            '카카오로 로그인',
            style: TextStyle(
              fontFamily: 'gmarketSans',
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
