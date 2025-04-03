import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/bill_info/presentation/view/recent_bill_post_tag_modal_view.dart';
import 'package:front/features/bill_info/presentation/view/recent_bill_thumbnail_widget.dart';
import 'package:front/features/bill_info/presentation/viewmodel/recent_bill_post_viewmodel.dart';
import 'package:front/features/bill_info/presentation/viewmodel/recent_bill_tag_viewmodel.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/party.dart';
import 'package:front/features/shared/view/appbar.dart';

class RecentBillThumbnailView extends ConsumerWidget {

  static const TextStyle _tagStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: ColorPalette.borderBlack
  );

  const RecentBillThumbnailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: const TextAppBar(title: "최근 접수 법안"),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 70),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorPalette.innerContent
                    ),
                    child: const Column(
                      children: [
                        Text("2024년 5월 30일 이후에 발의된 모든 법안들을 조회할 수 있어요", style: TextStylePreset.innerContentSubtitle,),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverCustomHeaderDelegate(
                      minHeight: 50,
                      maxHeight: 50,
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
              ref.read(recentBillProvider.notifier).nextPage();
            }
            return false;
          },
          child: const RecentBillThumbnailWidget(),
        )
      )
    );
  }
  
  Widget _buildPreferredTags(WidgetRef ref, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: IconButton(onPressed: () => {_showPersistentBottomSheet(context)}, icon: const Icon(Icons.filter_list)),
            ),
            _createTag(BillProposerTypeTag.lawmaker, const Text("의원 발의"), ref),
            _createTag(ProgressStatusTag.promulgated, const Text("공포"), ref),
            _createTag(ProgressStatusTag.plenaryDecided, const Text("본회의의결"), ref),
            _createTag(PartyTag.democratic, Party.democratic.svgPicture, ref),
            _createTag(PartyTag.peoplePower, Party.peoplePower.svgPicture, ref),
          ]
      ),
    );
  }

  Widget _createTag(BillPostTag tag, Widget label, WidgetRef ref) {
    final state =  ref.watch(recentBillTagProvider);
    final stateNotifier = ref.read(recentBillTagProvider.notifier);
    final billFetchNotifier = ref.read(recentBillProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
          clipBehavior: Clip.hardEdge,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 0),
          backgroundColor: ColorPalette.innerContent,
          selectedColor: ColorPalette.greyLight,
          labelStyle: _tagStyle,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: ColorPalette.greyDark,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          label: Container(
            height: 20,
            alignment: Alignment.bottomCenter,
            child: label,
          ),
          selected: state.contains(tag),
          onSelected: (selected) {
            stateNotifier.toggleTag(tag);
            billFetchNotifier.changeTags(ref.read(recentBillTagProvider).toList());
          }
      ),
    );
  }

  void _showPersistentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black54,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // 화면 차지 비율
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: ColorPalette.whitePrimary,
            ),
            child: const RecentBillPostTagModalView(),
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