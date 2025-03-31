import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_bill_post_viewmodel.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/view/error.dart';

class CommitteeBillPostThumbnailWidget extends ConsumerStatefulWidget {
  final Committee _committee;

  const CommitteeBillPostThumbnailWidget(this._committee, {super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommitteeBillPostWidgetState();
}

class _CommitteeBillPostWidgetState extends ConsumerState<CommitteeBillPostThumbnailWidget>{

  @override
  void initState() {
    super.initState();
    ref.read(committeeBillPostProvider(widget._committee).notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final billPostState = ref.watch(committeeBillPostProvider(widget._committee));
    List<BillThumbnail> allFetchedThumbnails = billPostState.getFetchedBill();
    if(billPostState.fetchingBills.hasError) {
      return const SomethingWentWrongWidget();
    }
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final bill = allFetchedThumbnails[index];
              return Container(
                margin: const EdgeInsets.all(10),
                child: _createTodayBillThumbnailCard(bill),
              );
            },
            childCount: allFetchedThumbnails.length,
          ),
        ),
        SliverToBoxAdapter( // 로딩 인디케이터
          child: billPostState.fetchingBills.when(
            data: (data) => const SizedBox(),
            error: (error, stack) => const SizedBox(),
            loading: () => Align(
              alignment: Alignment.center, // ✅ 중앙 정렬
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: 30,
                height: 30,
                child: const CircularProgressIndicator(color: ColorPalette.bluePrimary),
              ),
            ),
          )
        ),
      ],
    );
  }


  Card _createTodayBillThumbnailCard(BillThumbnail thumbnail) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: ColorPalette.innerContent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: ColorPalette.borderLight,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: InkWell(
        onTap: () => ApplicationNavigatorService.pushToBillDetail(billId: thumbnail.billId, title: "오늘 접수된 법안"),
        child: SizedBox(
          height: 120,
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Text(
                  thumbnail.billName,
                  style: TextStylePreset.thumbnailTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 16,
                child: Text(
                  thumbnail.proposers,
                  style: TextStylePreset.thumbnailSubtitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagFilter(WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: ProgressStatusTag.getTagsAfterPlenarySubmitted().map((tag) {
          final isSelected = ref.watch(committeeBillPostProvider(widget._committee)).selectedTags.contains(tag);
          return ChoiceChip(
            label: Text(tag.value.value),
            selected: isSelected,
            onSelected: (selected) => ref.read(committeeBillPostProvider(widget._committee).notifier).toggleTag(tag),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPartyTag(WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: PartyTag.getAll().map((tag) {
          final isSelected = ref.watch(committeeBillPostProvider(widget._committee)).selectedTags.contains(tag);
          return ChoiceChip(
            label: SizedBox(width: 40, height: 40, child: tag.value.svgPicture),
            selected: isSelected,
            onSelected: (selected) => ref.read(committeeBillPostProvider(widget._committee).notifier).toggleTag(tag),
          );
        }).toList(),
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _SliverHeaderDelegate({required this.child, required this.minHeight, required this.maxHeight});

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.minHeight != minHeight || oldDelegate.maxHeight != maxHeight;
  }
}
