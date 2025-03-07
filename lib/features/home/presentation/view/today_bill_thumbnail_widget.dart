import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/home/presentation/viewmodel/get_today_bill_thumbnails_provider.dart';
import 'package:provider/provider.dart';

import 'package:front/features/home/domain/entities/today_bill_thumbnail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TodayBillThumbnailWidget extends StatelessWidget {

  static final PageController pageController = PageController(viewportFraction: 1.0);

  const TodayBillThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    GetTodayBillThumbnailsProvider provider =
        Provider.of(context, listen: false);
    return FutureBuilder(
        future: provider.fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _createTodayBillSection(const Center(child: CircularProgressIndicator())) ;
          }
          if (snapshot.hasError) {
            return _createTodayBillSection(const Text("Err"));
          }
          return _createTodayBillSection(_todayBillSectionInnerContent(provider.thumbnails));
        });
  }

  Widget _createTodayBillSection(Widget innerContent) {
    return Column(
      children: [
        _createSectionTitle(),
        innerContent,
      ],
    );
  }
  
  Column _todayBillSectionInnerContent(List<TodayBillThumbnail> thumbnails) {
    return Column(
      children: [
       _buildTodayBillThumbnailCard(thumbnails),
        Container(
          decoration: const BoxDecoration(
            color: ColorPalette.innerContent,
            borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
          ),
          child: _pageIndicator(thumbnails.length ~/ 4 + 1),
        )
      ]
    );
  }

  Row _createSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ 좌우 끝 정렬
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text("오늘 접수된 법안", style: TextStylePreset.sectionTitle),
        ),
        TextButton(
          onPressed: ()  => print("clicked 더보기") ,
          child: const Text("더보기",style: TextStylePreset.thumbnailSubtitle,
          )
        ),
      ],
    );
  }

  Widget _buildTodayBillThumbnailCard(List<TodayBillThumbnail> thumbnails) {
    return Container( // ✅ 고정된 높이 설정
      height: 465,
      decoration: const BoxDecoration(
          color: ColorPalette.innerContent,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),)
      ),
      child: _buildTodayBillThumbnailPages(thumbnails),
    );
  }

  Widget _buildTodayBillThumbnailPages(List<TodayBillThumbnail> thumbnails) {
    int itemsPerPage = 4; // 한 페이지당 4개 요소 표시
    int pageCount = (thumbnails.length / itemsPerPage).ceil();
    return PageView.builder(
      itemCount: pageCount,
      controller: pageController,
      itemBuilder: (context, pageIndex) {
        int startIndex = pageIndex * itemsPerPage;
        int endIndex = (startIndex + itemsPerPage).clamp(0, thumbnails.length);
        List<TodayBillThumbnail> pageItems =
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

  Container _pageIndicator(int pageSize) {
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

  Card _createTodayBillThumbnailCard(TodayBillThumbnail thumbnail) {
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
        onTap: () => print(thumbnail.billId),
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
