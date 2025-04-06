import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/pre_announce/domain/entities/preannounce_bill_thumbnail.dart';
import 'package:front/features/pre_announce/presentation/view/d_day_widget.dart';
import 'package:front/features/pre_announce/presentation/viewmodel/preannounce_thumbnail_viewmodel.dart';
import 'package:front/features/shared/view/error.dart';

class PreAnnounceThumbnailWidget extends ConsumerStatefulWidget {

  const PreAnnounceThumbnailWidget({super.key});

  @override
  ConsumerState<PreAnnounceThumbnailWidget> createState() => PreAnnounceThumbnailWidgetState();
}

class PreAnnounceThumbnailWidgetState extends ConsumerState<PreAnnounceThumbnailWidget> {

  @override
  void initState() {
    ref.read(preAnnounceThumbnailProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final billPostState = ref.watch(preAnnounceThumbnailProvider);
    List<PreAnnounceBillThumbnail> allFetchedThumbnails = billPostState.getFetchedBill();
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
                child: _createPreAnnounceBillThumbnail(bill),
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

  Widget _createPreAnnounceBillThumbnail(PreAnnounceBillThumbnail thumbnail) {
    return Material(
      color: ColorPalette.innerContent,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => print("to preannouncebilldetail"),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DdayWidget(dDay: thumbnail.dDay),
                    const SizedBox(width: 10),
                    Expanded( // ✅ 핵심! 가용 공간 안에서 줄바꿈 가능하게 함
                      child: Text(
                        thumbnail.billName,
                        style: TextStylePreset.thumbnailTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment : MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    thumbnail.proposers,
                    style: TextStylePreset.thumbnailSubtitle,
                  ),
                  if(thumbnail.legislativeBody != null)
                    Text(
                      thumbnail.legislativeBody!,
                      style: TextStylePreset.thumbnailSubtitle,
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}