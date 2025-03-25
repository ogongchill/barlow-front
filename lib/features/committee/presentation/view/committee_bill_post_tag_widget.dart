import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_bill_post_viewmodel.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/committee.dart';

import 'package:front/core/theme/color_palette.dart';

class CommitteeBillPostTagWidget extends ConsumerWidget {

  final Committee committee;

  const CommitteeBillPostTagWidget(this.committee, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildProgressStatusTag(ref),
        _buildPartyTag(ref)
      ],
    );
  }

  Widget _buildPartyTag(WidgetRef ref) {
    List<PartyTag> availableTags = PartyTag.getAll();

    final state =  ref.watch(committeeBillPostProvider(committee));
    final stateNotifier = ref.read(committeeBillPostProvider(committee).notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: availableTags.map((tag) {
          final isSelected = state.selectedTags.contains(tag);
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
                padding: EdgeInsets.symmetric(vertical: 10),
                backgroundColor: ColorPalette.innerContent,
                selectedColor: ColorPalette.greyLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // ✅ 사각형 유지 (둥글게 하려면 숫자 조정)
                ),
                label: SizedBox(
                  width: 40,
                  height: 40,
                  child: tag.value.svgPicture,
                ),
                selected: isSelected,
                onSelected: (selected) => stateNotifier.toggleTag(tag)
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProgressStatusTag(WidgetRef ref) {
    List<ProgressStatusTag> availableTags = ProgressStatusTag.getAll();

    final state =  ref.watch(committeeBillPostProvider(committee));
    final stateNotifier = ref.read(committeeBillPostProvider(committee).notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: availableTags.map((tag) {
          final isSelected = state.selectedTags.contains(tag);
          return Row(
            children: [
              ChoiceChip(
                  label: Text(tag.value.value, style: TextStylePreset.thumbnailTitle,),
                  backgroundColor: ColorPalette.innerContent,
                  selectedColor: ColorPalette.greyLight,
                  selected: isSelected,
                  onSelected: (selected) => stateNotifier.toggleTag(tag)
              ),
              if(tag != ProgressStatusTag.promulgated) // 화살표 표시
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: const Icon(Icons.arrow_forward_ios_rounded, color: ColorPalette.greyLight,),
                )
            ],
          );
        }).toList(),
      ),
    );
  }
}