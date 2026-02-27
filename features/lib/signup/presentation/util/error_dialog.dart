import 'package:design_system/theme/color_palette.dart';
import 'package:flutter/material.dart';

/// signup 흐름에서 공통으로 사용하는 에러 팝업.
///
/// 확인 버튼을 누를 때까지 다이얼로그를 유지한다.
/// 호출 측에서 await 후 후속 동작(리셋/이동)을 처리한다.
Future<void> showSignupErrorDialog({
  required BuildContext context,
  required String message,
  required Function onPressed,
  required String title
}) async {
  if (!context.mounted) return;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: ColorPalette.background,
      title: Text(
        title,
        style: TextStyle(fontFamily: 'gmarketSans', fontWeight: FontWeight.w700),
      ),
      content: Text(message, style: const TextStyle(fontFamily: 'gmarketSans')),
      actions: [
        TextButton(
          onPressed: () => onPressed(),
          child: const Text('확인', style: TextStyle(fontFamily: 'gmarketSans', fontWeight: FontWeight.w500, color: ColorPalette.greyDark)),
        ),
      ],
    ),
  );
}
