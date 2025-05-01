import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/bill_info/presentation/viewmodel/recent_bill_post_viewmodel.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/view/error.dart';

class RecentBillThumbnailWidget extends ConsumerStatefulWidget {

  const RecentBillThumbnailWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecentBillThumbnailState();
}

class _RecentBillThumbnailState extends ConsumerState<RecentBillThumbnailWidget> {

  @override
  Widget build(BuildContext context) {
    final billPostState = ref.watch(recentBillProvider);
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
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: _createTodayBillThumbnailCard(bill),
              );
            },
            childCount: allFetchedThumbnails.length,
          ),
        ),
        SliverToBoxAdapter( // 로딩 인디케이터
            child: billPostState.fetchingBills.when(
              data: (data) => const SizedBox(),
              error: (error, stack) {
                print("ERROR : $error");
                return const SomethingWentWrongWidget();
              } ,
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
          width: 0,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: InkWell(
        onTap: () => ApplicationNavigatorService.pushToBillDetail(billId: thumbnail.billId, title: "최근 접수 법안"),
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


  @override
  void initState() {
    super.initState();
    ref.read(recentBillProvider.notifier).init();
  }
}