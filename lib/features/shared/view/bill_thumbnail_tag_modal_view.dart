import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';

class BillThumbnailTagModalView extends ConsumerWidget {

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

  static const TextStyle _selectedCommittee = TextStyle(
      fontFamily: "gmarketSans",
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: ColorPalette.whitePrimary
  );

  static const TextStyle _unselectedCommittee = TextStyle(
      fontFamily: "gmarketSans",
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: ColorPalette.textHead
  );


  dynamic billThumbnailProvider;
  dynamic billTagProvider;
  final bool _containsPartyTag;
  final bool _containsProposerTypeTag;
  final bool _containsProgressStatusTag;
  final bool _containsCommitteeTag;

  BillThumbnailTagModalView({
    super.key,
    required this.billThumbnailProvider,
    required this.billTagProvider,
    bool? containsPartyTag,
    bool? containsProposerTypeTag,
    bool? containsProgressStatusTag,
    bool? containsCommitteeTag
  }) : _containsPartyTag = containsPartyTag ?? false,
       _containsProposerTypeTag = containsProposerTypeTag ?? false,
       _containsProgressStatusTag = containsProgressStatusTag ?? false,
       _containsCommitteeTag = containsCommitteeTag ?? false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 30),
          decoration: const BoxDecoration(
              color: ColorPalette.greyDark,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          height: 3,
          width: 50,
        ),
        if(_containsPartyTag)
          _buildPartyTags(ref),
        if(_containsProposerTypeTag)
          _buildProposerTypeTag(ref),
        if(_containsProgressStatusTag)
          _buildProgressStatusTag(ref),
        if(_containsCommitteeTag)
          _buildCommitteeTags(ref),
        const Expanded(child: SizedBox()),
        Align(
          alignment: Alignment.bottomCenter,
          child: _tagButtons(context, ref),
        )
      ],
    );
  }

  Widget _buildProposerTypeTag(WidgetRef ref) {
    final List<BillProposerTypeTag> availableTags = BillProposerTypeTag.getAll();
    final billPostTagState = ref.read(billTagProvider);
    final billPostTagNotifier = ref.read(billTagProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text("발의자 구분", style: TextStylePreset.sectionTitle,)
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

  Widget _buildProgressStatusTag(WidgetRef ref) {
    final List<ProgressStatusTag> availableTags = ProgressStatusTag.getTagsAfterPlenarySubmitted();
    final billPostTagState = ref.watch(billTagProvider);
    final billPostTagNotifier = ref.read(billTagProvider.notifier);

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
    final billPostTagState = ref.watch(billTagProvider);
    final billPostTagNotifier = ref.read(billTagProvider.notifier);

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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // ✅ 스크롤 방지 (부모 스크롤과 충돌 방지)
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, //  가로 4개씩 배치
                crossAxisSpacing: 8.0, //  가로 간격
                mainAxisSpacing: 8.0, //  세로 간격
                childAspectRatio: 1.0, // 사각형 형태 유지
              ),
              itemCount: availableTags.length,
              itemBuilder: (context, index) {
                final tag = availableTags[index];
                final isSelected = billPostTagState.contains(tag);

                return ChoiceChip(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: ColorPalette.whitePrimary,
                  selectedColor: ColorPalette.greyLight,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                          color: ColorPalette.whitePrimary
                      )//
                  ),
                  label: AnimatedContainer(
                    duration: const Duration(milliseconds: 200), //  부드러운 애니메이션
                    width: isSelected ? 50 : 40, // 선택 시 커지는 효과
                    height: isSelected ? 50 : 40,
                    child: FittedBox(
                      fit: BoxFit.contain, // 또는 BoxFit.scaleDown
                      child: tag.value.svgPicture,
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

  Widget _buildCommitteeTags(WidgetRef ref) {
    final List<CommitteeTag> availableTags = CommitteeTag.getAll();
    final billPostTagState = ref.watch(billTagProvider);
    final billPostTagNotifier = ref.read(billTagProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text("소관 상임위원회", style: TextStylePreset.sectionTitle,)
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: IntrinsicWidth(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.0, // 요소 간 가로 간격
                  runSpacing: 2, // 요소 간 세로 간격
                  children: availableTags.map((tag) {
                    final isSelected = billPostTagState.contains(tag);
                    return ChoiceChip(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      label: isSelected
                          ? Text(tag.value.name, style: _selectedCommittee)
                          : Text(tag.value.name, style: _unselectedCommittee),
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

  Widget _tagButtons(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
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
    final billPostNotifier = ref.read(billTagProvider.notifier);
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
    final List<BillPostTag> selectedTags = ref.read(billTagProvider).toList();
    final billPostNotifier = ref.read(billThumbnailProvider.notifier);
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
          child: Text("${selectedTags.length}개 태그 적용하기", style: _submitButtonStyle, textAlign: TextAlign.center,),
        )
    );
  }
}