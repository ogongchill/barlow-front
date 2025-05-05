import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_bill_post_viewmodel.dart';
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
    if(allFetchedThumbnails.isEmpty && !billPostState.fetchingBills.isLoading) {
      return Container(
        color: ColorPalette.innerContent,
        child: const Center(child: Text("조회된 법안이 없어요", style: TextStylePreset.sectionTitle,),),
      );
    }
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
        onTap: () => ApplicationNavigatorService.pushToBillDetail(billId: thumbnail.billId, title: widget._committee.value),
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
              Positioned(
                bottom: 10,
                right: 16,
                child: Text(
                  thumbnail.legislativeBody ?? "",
                  style: TextStylePreset.thumbnailSubtitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
