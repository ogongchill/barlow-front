import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/presentation/viewmodel/committe_bill_post_tag_viewmodel.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_bill_post_viewmodel.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/committee.dart';

import 'package:front/core/theme/color_palette.dart';

class CommitteeBillPostTagModalView extends ConsumerWidget {

  static const TextStyle _submitButtonStyle = TextStyle(
    fontFamily: "gmarketSans",
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorPalette.whitePrimary
  );

  static const TextStyle _resetButtonStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ColorPalette.textHead
  );

  static const TextStyle _selectedProgressStatus = TextStyle(
      fontFamily: "gmarketSans",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ColorPalette.whitePrimary
  );

  static const TextStyle _unselectedProgress = TextStyle(
      fontFamily: "gmarketSans",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ColorPalette.textHead
  );

  final Committee committee;

  const CommitteeBillPostTagModalView({
    required this.committee,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // 🔒 상단 핸들 (고정)
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 16),
          height: 4,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // 🔄 스크롤 가능한 콘텐츠 영역
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              _buildProgressStatusTag(ref),
              const SizedBox(height: 16),
              _buildPartyTags(ref),
              const SizedBox(height: 16),
            ],
          ),
        ),
        // 🔒 하단 버튼 (고정)
        _tagButtons(context, ref),
      ],
    );
  }

  Widget _buildProgressStatusTag(WidgetRef ref) {
    final List<ProgressStatusTag> availableTags = [
      ProgressStatusTag.committeeReceived,
      ProgressStatusTag.committeeReview,
      ProgressStatusTag.promulgated,
      ProgressStatusTag.replacedAndDiscarded,
    ];
    final billPostTagState = ref.watch(billPostTagProvider(committee));
    final billPostTagNotifier = ref.read(billPostTagProvider(committee).notifier);

    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text("법률안 처리 절차", style: TextStylePreset.sectionTitle,)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: IntrinsicWidth(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.0, // 요소 간 가로 간격
                runSpacing: 8.0, // 요소 간 세로 간격
                children: availableTags.map((tag) {
                  final isSelected = billPostTagState.contains(tag);
                  return ChoiceChip(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    label: isSelected
                      ? Text(tag.value.value, style: _selectedProgressStatus)
                      : Text(tag.value.value, style: _unselectedProgress),
                    backgroundColor: ColorPalette.innerContent,
                    selectedColor: ColorPalette.bluePrimary,
                    selected: isSelected,
                    onSelected: (selected) => billPostTagNotifier.toggleTag(tag),
                  );
                }).toList(),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildPartyTags(WidgetRef ref) {
    final List<PartyTag> availableTags = PartyTag.getAll();
    final billPostTagState = ref.watch(billPostTagProvider(committee));
    final billPostTagNotifier = ref.read(billPostTagProvider(committee).notifier);

    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("정당별", style: TextStylePreset.sectionTitle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // ✅ 스크롤 방지 (부모 스크롤과 충돌 방지)
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, //  가로 4개씩 배치
                crossAxisSpacing: 10.0, //  가로 간격
                mainAxisSpacing: 1.0, //  세로 간격
                childAspectRatio: 1.0, // 사각형 형태 유지
              ),
              itemCount: availableTags.length,
              itemBuilder: (context, index) {
                final tag = availableTags[index];
                final isSelected = billPostTagState.contains(tag);
                return ChoiceChip(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: ColorPalette.whitePrimary,
                  selectedColor: ColorPalette.whitePrimary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  label: SizedBox(
                    width: 50,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedScale(
                          scale: isSelected ? 1.2 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: tag.value.svgPicture,
                        ),
                        if (!isSelected)
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration:
                            const BoxDecoration(
                              color: Colors.white30,
                            ),
                          ),
                      ],
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) => billPostTagNotifier.toggleTag(tag),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPartyTags(WidgetRef ref) {
  //   final List<PartyTag> availableTags = PartyTag.getAll();
  //   final billPostTagState = ref.watch(billPostTagProvider(committee));
  //   final billPostTagNotifier = ref.read(billPostTagProvider(committee).notifier);
  //
  //   return Container(
  //     padding: const EdgeInsets.all(5),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 20),
  //           child: Text("정당별", style: TextStylePreset.sectionTitle),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
  //           child: GridView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(), // ✅ 스크롤 방지 (부모 스크롤과 충돌 방지)
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 4, // ✅ 가로 4개씩 배치
  //               crossAxisSpacing: 8.0, // ✅ 가로 간격
  //               mainAxisSpacing: 8.0, // ✅ 세로 간격
  //               childAspectRatio: 1.0, // ✅ 정사각형 형태 유지
  //             ),
  //             itemCount: availableTags.length,
  //             itemBuilder: (context, index) {
  //               final tag = availableTags[index];
  //               final isSelected = billPostTagState.contains(tag);
  //
  //               return ChoiceChip(
  //                 padding: const EdgeInsets.symmetric(vertical: 10),
  //                 backgroundColor: ColorPalette.whitePrimary,
  //                 selectedColor: ColorPalette.greyLight,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                   side: const BorderSide(
  //                     color: ColorPalette.whitePrimary
  //                   )//
  //                 ),
  //                 label: AnimatedContainer(
  //                   duration: const Duration(milliseconds: 200), // ✅ 부드러운 애니메이션
  //                   width: isSelected ? 60 : 40, // ✅ 선택 시 커지는 효과
  //                   height: isSelected ? 60 : 40,
  //                   child: FittedBox(
  //                     fit: BoxFit.contain, // 또는 BoxFit.scaleDown
  //                     child: tag.value.svgPicture,
  //                   ),
  //                 ),
  //                 selected: isSelected,
  //                 onSelected: (selected) => billPostTagNotifier.toggleTag(tag),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  Widget _tagButtons(BuildContext context, WidgetRef ref) {
    return Container(
      color: ColorPalette.greyLight,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          _resetButton(ref),
          _submitButton(ref, context)
        ],
      ),
    );
  }

  Widget _resetButton(WidgetRef ref) {
    final billPostNotifier = ref.read(billPostTagProvider(committee).notifier);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: ColorPalette.innerContent,
            overlayColor: ColorPalette.greyLight,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: ColorPalette.greyLight, width: 1),
                borderRadius: BorderRadius.circular(10)
            )
        ),
        onPressed: () => billPostNotifier.resetTag(),
        child: const Text("초기화", style: _resetButtonStyle)
    );
  }

  Widget _submitButton(WidgetRef ref, BuildContext context) {
    final List<BillPostTag> selectedTags = ref.read(billPostTagProvider(committee)).toList();
    final billPostNotifier = ref.read(committeeBillPostProvider(committee).notifier);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: ColorPalette.bluePrimary,
            overlayColor: ColorPalette.greyLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        onPressed: () {
          billPostNotifier.changeTags(selectedTags);
          Navigator.pop(context);
        },
        child: SizedBox(
          width: 150,
          child: Text("${selectedTags.length}개 태그 적용", style: _submitButtonStyle, textAlign: TextAlign.center,),
        )
    );
  }

  // Widget _tagButtons(BuildContext context, WidgetRef ref) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 30),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       spacing: 10,
  //       children: [
  //         _resetButton(ref),
  //         _submitButton(ref, context)
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _resetButton(WidgetRef ref) {
  //   final billPostNotifier = ref.read(billPostTagProvider(committee).notifier);
  //   return ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //           elevation: 0,
  //           shadowColor: Colors.transparent,
  //           backgroundColor: ColorPalette.innerContent,
  //           overlayColor: ColorPalette.greyLight,
  //           shape: RoundedRectangleBorder(
  //               side: const BorderSide(color: ColorPalette.greyLight, width: 1),
  //               borderRadius: BorderRadius.circular(10)
  //           )
  //       ),
  //       onPressed: () => billPostNotifier.resetTag(),
  //       child: const Text("초기화", style: _resetButtonStyle)
  //   );
  // }
  //
  // Widget _submitButton(WidgetRef ref, BuildContext context) {
  //   final List<BillPostTag> selectedTags = ref.read(billPostTagProvider(committee)).toList();
  //   final billPostNotifier = ref.read(committeeBillPostProvider(committee).notifier);
  //   return ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         elevation: 0,
  //         shadowColor: Colors.transparent,
  //         backgroundColor: ColorPalette.bluePrimary,
  //         overlayColor: ColorPalette.greyLight,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10)
  //         )
  //       ),
  //       onPressed: () {
  //         billPostNotifier.changeTags(selectedTags);
  //         Navigator.pop(context);
  //       },
  //       child: SizedBox(
  //         width: 150,
  //         child: Text("${selectedTags.length}개 태그 적용하기", style: _submitButtonStyle, textAlign: TextAlign.center,),
  //       )
  //   );
  // }
}