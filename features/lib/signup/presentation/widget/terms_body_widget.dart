import 'package:design_system/theme/color_palette.dart';
import 'package:features/signup/presentation/viewmodel/term_agreement_state.dart';
import 'package:features/signup/presentation/widget/term_item.dart';
import 'package:flutter/material.dart';

/// 약관 동의 화면의 본문 영역.
///
/// 닉네임 입력 필드, 전체 동의 토글, 개별 약관 목록을 표시한다.
/// viewmodel에 의존하지 않으며 파라미터만으로 동작한다.
class TermsBodyWidget extends StatelessWidget {
  final TermAgreementIdle idle;
  final TextEditingController nicknameController;
  final VoidCallback onToggleAll;
  final void Function(int termId) onToggleTerm;

  const TermsBodyWidget({
    super.key,
    required this.idle,
    required this.nicknameController,
    required this.onToggleAll,
    required this.onToggleTerm,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 닉네임 입력
          Container(
            decoration: BoxDecoration(
              color: ColorPalette.innerContent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorPalette.borderLight),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: nicknameController,
              style: const TextStyle(fontFamily: 'gmarketSans', fontSize: 15),
              decoration: const InputDecoration(
                hintText: '닉네임을 입력해주세요',
                hintStyle: TextStyle(
                  fontFamily: 'gmarketSans',
                  color: ColorPalette.greyDark,
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // 전체 동의 토글
          GestureDetector(
            onTap: onToggleAll,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: ColorPalette.innerContent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: idle.isAllAgreed
                      ? ColorPalette.orangePrimary
                      : ColorPalette.borderLight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    idle.isAllAgreed
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline_rounded,
                    color: idle.isAllAgreed
                        ? ColorPalette.orangePrimary
                        : ColorPalette.greyDark,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '전체 동의',
                    style: TextStyle(
                      fontFamily: 'gmarketSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // 약관 항목 목록
          ...idle.terms.map(
            (term) => TermItem(
              term: term,
              onToggle: () => onToggleTerm(term.id),
            ),
          ),
        ],
      ),
    );
  }
}
