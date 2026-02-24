import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/text_style_preset.dart';
import 'package:features/bill/domain/entities/bill_detail.dart';
import 'package:features/bill/presentation/viewmodel/bill_ai_summary_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillAiSummaryView extends ConsumerWidget {
  final BillAiSummary? summary;
  final String billId;

  const BillAiSummaryView({
    super.key,
    required this.summary,
    required this.billId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // summary가 null이면 아무것도 렌더링하지 않음
    if (summary == null) {
      return const SizedBox.shrink();
    }

    final viewModel = ref.watch(billAiSummaryViewModelProvider(billId).notifier);
    final state = ref.watch(billAiSummaryViewModelProvider(billId));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: ColorPalette.innerContent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorPalette.greyLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(viewModel, state),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: state.isExpanded ? null : 0,
            child: state.isExpanded ? _buildContent() : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BillAiSummaryViewModel viewModel, BillAiSummaryState state) {
    return InkWell(
      onTap: viewModel.toggleExpansion,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ColorPalette.greyLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 14,
                    color: ColorPalette.greyLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'AI',
                    style: TextStylePreset.innerContentSubtitle.copyWith(
                      color: ColorPalette.greyLight,
                      fontWeight: FontWeight.w500,
                      fontFamily: "GmarketSans",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                summary!.title,
                style: TextStylePreset.billDetailText.copyWith(
                  fontWeight: FontWeight.w500,
                  fontFamily: "GmarketSans",
                ),
              ),
            ),
            AnimatedRotation(
              turns: state.isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: ColorPalette.greyDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorPalette.greyLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: ColorPalette.greyDark,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '이 요약은 AI가 법안 내용을 분석하여 생성한 것입니다. 정확한 내용은 전체 법안 문서를 확인해 주세요.',
                    style: TextStylePreset.innerContentSubtitle.copyWith(
                      color: ColorPalette.greyLight,
                      fontSize: 12,
                      fontFamily: "GmarketSans",
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            summary!.detail,
            style: TextStylePreset.billDetailText.copyWith(
              height: 1.6,
              fontFamily: "GmarketSans",
            ),
          ),
        ],
      ),
    );
  }
}