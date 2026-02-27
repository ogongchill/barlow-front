import 'package:design_system/theme/color_palette.dart';
import 'package:flutter/material.dart';

/// 약관 동의 화면 하단의 '가입하기' 버튼 영역.
///
/// viewmodel에 의존하지 않으며 파라미터만으로 동작한다.
class SubmitBarWidget extends StatelessWidget {
  final bool canSubmit;
  final bool isLoading;
  final VoidCallback? onSubmit;

  const SubmitBarWidget({
    super.key,
    required this.canSubmit,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onSubmit,
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              decoration: BoxDecoration(
                color: canSubmit
                    ? ColorPalette.orangePrimary
                    : ColorPalette.greyLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                height: 52,
                alignment: Alignment.center,
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        '가입하기',
                        style: TextStyle(
                          fontFamily: 'gmarketSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: canSubmit
                              ? Colors.white
                              : ColorPalette.greyDark,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
