import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/home/presentation/viewmodel/home_view_provider.dart';

import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TodayBillThumbnailWidget extends ConsumerWidget{

  static final PageController pageController = PageController(viewportFraction: 1.0);

  const TodayBillThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(todayBillThumbnailsProvider);
    return asyncValue.when(
        data: (thumbnails) => _buildWidgetWIth(_buildInnerContent(thumbnails)),
        error: (err, stack) =>_buildWidgetWIth(const Text("something went wrong,,,,")) ,
        loading: () => _buildWidgetWIth(_buildShimmerLoading())
    );
  }

  Widget _buildWidgetWIth(Widget innerContent) {
    return Column(
      children: [
        _buildTitle(),
        innerContent,
      ],
    );
  }

  Column _buildInnerContent(List<BillThumbnail> thumbnails) {
    return Column(
        children: [
          _buildTodayBillThumbnailCard(thumbnails),
          Container(
            decoration: const BoxDecoration(
                color: ColorPalette.innerContent,
                borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
            ),
            child: _buildPageIndicator(thumbnails.length ~/ 4 + 1),
          )
        ]
    );
  }

  Widget _buildTitle() {
    return Container(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: ColorPalette.innerContent
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ 좌우 끝 정렬
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text("오늘 접수된 법안", style: TextStylePreset.sectionTitle),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // 기본 텍스트 색상
                  overlayColor: Colors.grey.withOpacity(0.2), // ✅ 클릭 효과 색상을 회색으로 설정
                ),
                onPressed: ()  => print("clicked 더보기") ,
                child: const Text("더보기",style: TextStylePreset.thumbnailSubtitle,
                )
            ),
          ],
        )
    );
  }

  Widget _buildTodayBillThumbnailCard(List<BillThumbnail> thumbnails) {
    return Container( // ✅ 고정된 높이 설정
      height: 465,
      decoration: const BoxDecoration(
        color: ColorPalette.innerContent,
        borderRadius: BorderRadius.zero,
      ),
      child: _buildTodayBillThumbnailPages(thumbnails),
    );
  }

  Widget _buildTodayBillThumbnailPages(List<BillThumbnail> thumbnails) {
    int itemsPerPage = 4; // 한 페이지당 4개 요소 표시
    int pageCount = (thumbnails.length / itemsPerPage).ceil();
    return PageView.builder(
      itemCount: pageCount,
      controller: pageController,
      itemBuilder: (context, pageIndex) {
        int startIndex = pageIndex * itemsPerPage;
        int endIndex = (startIndex + itemsPerPage).clamp(0, thumbnails.length);
        List<BillThumbnail> pageItems =
        thumbnails.sublist(startIndex, endIndex);
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(), // PageView에서만 스크롤 가능하게 설정
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // 한 줄에 1개씩 배치
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3, // 요소 크기 조절
              mainAxisExtent: 100, // 각 아이템의 고정된 높이 설정
            ),
            itemCount: pageItems.length,
            itemBuilder: (context, index) {
              return _createTodayBillThumbnailCard(pageItems[index]);
            },
          ),
        );
      },
    );
  }

  Container _buildPageIndicator(int pageSize) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.center,
      child: SmoothPageIndicator(
          controller: pageController,
          count: pageSize,
          effect: const WormEffect(
            activeDotColor: ColorPalette.bluePrimary,
            radius: 8,
            spacing: 10,
            dotHeight: 8,
            dotWidth: 8,
          )),
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

  Widget _buildShimmerLoading() {
    return Column(
      children: [
        _buildShimmerCard(), // 🔥 로딩용 카드
        Container(
          decoration: const BoxDecoration(
              color: ColorPalette.innerContent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
          child: _buildPageIndicator(1), // Skeleton 로딩 중에도 페이지 인디케이터 유지
        ),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 465,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white, // Shimmer가 덮어씌우므로 중요하지 않음
          borderRadius: BorderRadius.zero,
          border: Border.all(color: ColorPalette.borderLight, width: 1),
        ),
      ),
    );
  }
}