import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/committee/presentation/view/committee_bill_post_tag_widget.dart';
import 'package:front/features/committee/presentation/view/committee_profile_widget.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_bill_post_viewmodel.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/domain/party.dart';
import 'package:front/features/shared/view/appbar.dart';
import 'package:front/features/committee/presentation/view/committee_bill_post_thumbnail_widget.dart';

class CommitteeProfileView extends ConsumerStatefulWidget {
  final Committee _committee;

  const CommitteeProfileView(this._committee, {super.key});

  @override
  ConsumerState<CommitteeProfileView> createState() => _CommitteeProfileViewState();
}

class _CommitteeProfileViewState extends ConsumerState<CommitteeProfileView> {

  static const TextStyle _tagStyle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: ColorPalette.greyDark
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextAppBar(
        title: widget._committee.name,
        onPressedBack: () => ApplicationNavigatorService.popWithResult(context),
      ),
      backgroundColor: ColorPalette.innerContent,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: CommitteeProfileWidget(widget._committee),
            ),
            SliverPersistentHeader(
              pinned: true, // ✅ 스크롤해도 고정됨
              delegate: _SliverCustomHeaderDelegate(
                minHeight: 70, // ✅ 최소 크기 (축소될 때 남는 부분)
                maxHeight: 70, // ✅ 최대 크기 (펼쳐졌을 때 크기)
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorPalette.innerContent,
                  ),
                  child: _buildPreferredTags(ref, context)
                )
              )
            ),
          ];
        },
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.extentAfter == 0) {
                ref.read(committeeBillPostProvider(widget._committee))
                  .fetchingBills.when(
                  data: (data) => ref.read(committeeBillPostProvider(widget._committee).notifier).nextPage(),
                  error: (error, stack) => {print("err")},
                  loading: () => {print("loading")}
              );
            }
            return false;
          },
          child: CommitteeBillPostThumbnailWidget(widget._committee),
        ),
      ),
    );
  }

  Widget _buildPreferredTags(WidgetRef ref, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: () => {_showPersistentBottomSheet(context)}, icon: const Icon(Icons.filter_list)),
          ),
          _createTag(ProgressStatusTag.promulgated, Text("공포")),
          _createTag(ProgressStatusTag.plenaryDecided, Text("본회의의결")),
          _createTag(PartyTag.democratic, Party.democratic.svgPicture),
          _createTag(PartyTag.peoplePower, Party.peoplePower.svgPicture)
        ]
      ),
    );
  }

  Widget _createTag(BillPostTag tag, Widget label) {
    final state =  ref.watch(committeeBillPostProvider(widget._committee));
    final stateNotifier = ref.read(committeeBillPostProvider(widget._committee).notifier);
    final isSelected = state.selectedTags.contains(tag);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
          clipBehavior: Clip.hardEdge,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 10),
          backgroundColor: ColorPalette.innerContent,
          selectedColor: ColorPalette.greyLight,
          labelStyle: _tagStyle,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: ColorPalette.greyLight,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8), // ✅ 사각형 유지 (둥글게 하려면 숫자 조정)
          ),
          label: Container(
            height: 25,
            alignment: Alignment.bottomCenter,
            child: label,
          ),
          selected: isSelected,
          onSelected: (selected) => stateNotifier.toggleTag(tag)
      ),
    );
  }

  void _showPersistentBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 600, // ✅ 고정된 높이
          color: ColorPalette.whitePrimary,
          child: CommitteeBillPostTagWidget(widget._committee),
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
