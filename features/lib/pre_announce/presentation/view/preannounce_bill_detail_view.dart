import 'package:design_system/theme/test_style_preset.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/pre_announce/domain/entities/preannounce_bill_detail.dart';
import 'package:features/pre_announce/presentation/view/d_day_widget.dart';
import 'package:features/pre_announce/presentation/viewmodel/preannounce_bill_detail_viewmodel.dart';
import 'package:features/shared/domain/committee.dart';
import 'package:features/shared/view/appbar.dart';
import 'package:features/shared/view/bill_detail_paragraph_widget.dart';
import 'package:features/shared/view/bill_proposer_section_widget.dart';
import 'package:features/shared/view/capturable_widget.dart';
import 'package:features/shared/view/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:design_system/theme/color_palette.dart';

class PreAnnounceBillDetailView extends ConsumerWidget {

  static const TextStyle _externalLinkTextStyle = TextStyle(
    color: ColorPalette.greyDark,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'gmarketSans'
  );
  final String billId;

  const PreAnnounceBillDetailView({super.key, required this.billId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final billDetail = ref.watch(preAnnounceBillDetailProvider(billId));
    return Scaffold(
      backgroundColor: ColorPalette.innerContent,
      appBar: TextAppBar(
        title: "진행중인 입법 예고",
        onPressedBack: () => ApplicationNavigatorService.popWithResult(context),
      ),
      body: billDetail.when(
          data: (billDetail) => _buildBody(billDetail),
          error: (error, stack) => const SomethingWentWrongWidget(),
          loading: () => Shimmer.fromColors(
            baseColor: Colors.grey[300]!, // 어두운 회색
            highlightColor: Colors.grey[100]!, // 밝은 회색
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
      )
    );
  }

  Widget _buildBody(PreAnnounceBillDetail billDetail) {
    return SingleChildScrollView(
      child: CaptureAndShareWidget(
          body: Container(
            color: ColorPalette.innerContent,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildPreAnnouncementSectionWidget(billDetail),
                BillDetailParagraphWidget(text: billDetail.detail),
                if(billDetail.preAnnouncementSection.linkUrl != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.black26,
                      elevation: 0
                    ),
                    onPressed: () => _openExternalBrowser(billDetail.preAnnouncementSection.linkUrl!),
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '국회에 의견 등록하러 가기 ',
                            style: _externalLinkTextStyle,
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.link_rounded, size: 16, color: ColorPalette.greyDark),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )
                  ),
                if(billDetail.proposerSection != null)
                  BillProposerSectionWidget(billProposerSection: billDetail.proposerSection!)
              ],
            ),
        )
      ),
    );
  }

  void _openExternalBrowser(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw 'URL 실행 불가: $url';
    }
  }

  Widget _buildPreAnnouncementSectionWidget(PreAnnounceBillDetail detail) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              DdayWidget(dDay: detail.preAnnouncementSection.dDAy),
              Expanded(
                child: Text(
                  detail.proposerSummary,
                  style: TextStylePreset.billDetailText,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(detail.title, style: TextStylePreset.billDetailHead),
          ),
          Row(
            spacing: 5,
            children: [
              _buildIconOrFallback(detail.legislativeBody),
              Text(detail.legislativeBody, style: TextStylePreset.innerContentSubtitle,)
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topRight,
            child: Text("${DateFormat('yyyy-MM-dd').format(detail.preAnnouncementSection.deadline)}까지", style: TextStylePreset.innerContentSubtitle),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildIconOrFallback(String legislativeBody) {
    try {
      return Committee.findByName(legislativeBody).icon.toSvgPicture();
    } catch (e) {
      return const SizedBox.shrink(); // 아이콘 대신 빈 박스
    }
  }
}