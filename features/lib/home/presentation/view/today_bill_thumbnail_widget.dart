import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/test_style_preset.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/shared/domain/bill_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TodayBillThumbnailWidget extends StatelessWidget{

  static final PageController pageController = PageController(viewportFraction: 1.0);

  final List<BillThumbnail> thumbnails;

  const TodayBillThumbnailWidget(this.thumbnails, {super.key});

  @override
  Widget build(BuildContext context) {
   if(thumbnails.isEmpty) {
      return Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(
            color: ColorPalette.innerContent,
            borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
        ),
        child: const Align(
          alignment: Alignment.center,
            child:Text("오늘 접수된 법안들이 \n아직 등록되지 않았어요", style: TextStylePreset.innerContentSubtitle, textAlign: TextAlign.center,)
        ),
      );
   }
   return _buildInnerContent(thumbnails);
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
}