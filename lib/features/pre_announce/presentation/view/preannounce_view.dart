import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/pre_announce/domain/repositories/sort_key.dart';
import 'package:front/features/pre_announce/presentation/view/preannounce_thumbnail_widget.dart';
import 'package:front/features/pre_announce/presentation/viewmodel/preannounce_thumbnail_tag_viewmodel.dart';
import 'package:front/features/pre_announce/presentation/viewmodel/preannounce_thumbnail_viewmodel.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/domain/legislative_process.dart';
import 'package:front/features/shared/domain/party.dart';
import 'package:front/features/shared/view/appbar.dart';
import 'package:front/features/shared/view/bill_thumbnail_tag_modal_view.dart';
import 'package:front/features/shared/view/legislative_process_widget.dart';
import 'package:front/features/shared/view/modal_drag_handle.dart';

class PreAnnounceView extends ConsumerWidget {

  static const TextStyle _tagStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: ColorPalette.borderBlack
  );

  static const TextStyle _sortKeyModalHeadStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w800,
      fontSize: 18,
      color: ColorPalette.borderBlack
  );

  static const TextStyle _sortKeyModalUnselectedStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: ColorPalette.borderBlack
  );

  static const TextStyle _sortKeyModalSelectedStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: ColorPalette.bluePrimary
  );

  const PreAnnounceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: ColorPalette.background,
        appBar: const TextAppBar(title: "진행중인 입법 예고"),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorPalette.innerContent
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const Text(
                                  "위원회에 회부된 법률안을 심사하기 전에 법률안의 입법 취지와 주요 내용 등을 국민들에게 미리 알리는 절차를 말해요\n",
                                  style: TextStylePreset.thumbnailTitle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                          const LegislativeProcessWidget(legislativeProcess: LegislativeProcess.priorAnnouncementOfLegislation),
                          const SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverCustomHeaderDelegate(
                        minHeight: 60,
                        maxHeight: 60,
                        child: Container(
                            decoration: const BoxDecoration(
                              color: ColorPalette.background,
                            ),
                            child: _buildPreferredTags(ref, context)
                        )
                    )
                ),
              ];
            },
            body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                  ref.read(preAnnounceThumbnailProvider.notifier).nextPage();
                }
                return false;
              },
              child: const PreAnnounceThumbnailWidget(),
            )
        )
    );
  }

  Widget _buildPreferredTags(WidgetRef ref, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        spacing: 10,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: () => {_showPersistentBottomSheet(context)}, icon: const Icon(Icons.filter_list)),
          ),
          _createTagBox(CommitteeTag.legislationAndJudiciary,  Text(Committee.legislationAndJudiciary.value, style: _tagStyle,), ref),
          _createTagBox(PartyTag.democratic, Party.democratic.toSvgPicture(24), ref),
          _createTagBox(PartyTag.peoplePower, Party.peoplePower.toSvgPicture(24), ref),
          _createSortFilter(context, ref)
        ]
      ),
    );
  }

  Widget _createTagBox(BillPostTag tag, Widget label, WidgetRef ref) {
    final state =  ref.watch(preAnnounceTagProvider);
    final stateNotifier = ref.read(preAnnounceTagProvider.notifier);
    final billFetchNotifier = ref.read(preAnnounceThumbnailProvider.notifier);
    bool isSelected = state.contains(tag);
    return Material(
      color: isSelected ? ColorPalette.greyLight : ColorPalette.innerContent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          stateNotifier.toggleTag(tag);
          billFetchNotifier.changeTags(ref.read(preAnnounceTagProvider).toList());
        },
        child: SizedBox(
          height: 34,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorPalette.greyDark, width: 1.0),
            ),
            child: Align(alignment: Alignment.center, child: label,),
          ),
        ),
      ),
    );
  }

  Widget _createSortFilter(BuildContext context, WidgetRef ref) {
    final state = ref.watch(preAnnounceSortKeyProvider);
    return Material(
      color: ColorPalette.innerContent, // 배경 투명하게
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _showSortKeyModal(context, ref),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 34, // choicechip 24 sized box + 5 x 2 의 padding
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorPalette.greyDark, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    state.isAscending ? "마감순" : "최신순",
                    style: _tagStyle,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: ColorPalette.borderBlack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSortKeyModal(BuildContext context, WidgetRef ref) {
    final sortKeyState = ref.watch(preAnnounceSortKeyProvider);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                color: ColorPalette.whitePrimary,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ModalDragHandle(),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("정렬", style: _sortKeyModalHeadStyle),
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          color: ColorPalette.greyLight,
                          thickness: 1.5,
                        )
                      ],
                    )
                  ),
                  Material( // 최신순 누르는 버튼
                    child: InkWell(
                      onTap: () {
                        ref.read(preAnnounceSortKeyProvider.notifier).toDsc();
                        ref.read(preAnnounceThumbnailProvider.notifier).changeSortKey(PreAnnounceBillPostSortKey.dsc);
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: ColorPalette.background,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("최신순으로 보기",
                              style: sortKeyState.isDescending
                                  ? _sortKeyModalSelectedStyle
                                  : _sortKeyModalUnselectedStyle),
                            if(sortKeyState.isDescending)
                              const Icon(Icons.check, color: ColorPalette.bluePrimary,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Material( // 마감순 버튼
                    child: InkWell(
                      onTap: () {
                        ref.read(preAnnounceSortKeyProvider.notifier).toAsc();
                        ref.read(preAnnounceThumbnailProvider.notifier).changeSortKey(PreAnnounceBillPostSortKey.asc);
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: ColorPalette.background,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("마감순으로 보기",
                                style: sortKeyState.isAscending
                                    ? _sortKeyModalSelectedStyle
                                    : _sortKeyModalUnselectedStyle),
                            if(sortKeyState.isAscending)
                              const Icon(Icons.check, color: ColorPalette.bluePrimary,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          );
        }
    );
  }

  void _showPersistentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black54,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.95, // 화면 차지 비율
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: ColorPalette.whitePrimary,
            ),
            child: BillThumbnailTagModalView(
                billThumbnailProvider: preAnnounceThumbnailProvider,
                billTagProvider: preAnnounceTagProvider,
                containsPartyTag: true,
                containsCommitteeTag: true,
            )
          ),
        );
      },
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _SliverCustomHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}