import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/presentation/view/committee_bill_post_tag_widget.dart';
import 'package:front/features/committee/presentation/view/committee_profile_widget.dart';
import 'package:front/features/committee/presentation/viewmodel/committe_bill_post_tag_viewmodel.dart';
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
        title: widget._committee.value,
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
                minHeight: 60, // ✅ 최소 크기 (축소될 때 남는 부분)
                maxHeight: 60, // ✅ 최대 크기 (펼쳐졌을 때 크기)
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
      padding: const EdgeInsets.all(0),
      child: Row(
        spacing: 10,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: () => {_showPersistentBottomSheet(context)}, icon: const Icon(Icons.filter_list)),
          ),
          _createTagBox(ProgressStatusTag.promulgated, const Text("공포", style: TextStylePreset.tagStyle,), ref),
          _createTagBox(ProgressStatusTag.plenaryDecided, const Text("본회의의결", style: TextStylePreset.tagStyle), ref),
          _createTagBox(PartyTag.democratic, Party.democratic.toSvgPicture(24), ref),
          _createTagBox(PartyTag.peoplePower, Party.peoplePower.toSvgPicture(24), ref)
        ]
      ),
    );
  }

  Widget _createTagBox(BillPostTag tag, Widget label, WidgetRef ref) {
    final state =  ref.watch(billPostTagProvider(widget._committee));
    final stateNotifier = ref.read(billPostTagProvider(widget._committee).notifier);
    final billFetchNotifier = ref.read(committeeBillPostProvider(widget._committee).notifier);
    bool isSelected = state.contains(tag);
    return Material(
      color: isSelected ? ColorPalette.greyLight : ColorPalette.innerContent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          stateNotifier.toggleTag(tag);
          billFetchNotifier.changeTags(ref.read(billPostTagProvider(widget._committee)).toList());
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

  void _showPersistentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black54,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7, // ✅ 화면의 60% 차지 (0.5로 설정하면 50%만 올라옴)
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: ColorPalette.whitePrimary,
            ),
            child: CommitteeBillPostTagModalView(widget._committee),
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
