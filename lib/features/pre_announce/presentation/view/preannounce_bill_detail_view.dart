import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/pre_announce/domain/entities/preannounce_bill_detail.dart';
import 'package:front/features/pre_announce/presentation/view/d_day_widget.dart';
import 'package:front/features/pre_announce/presentation/view/disclaimer_widget.dart';
import 'package:front/features/pre_announce/presentation/viewmodel/preannounce_bill_detail_viewmodel.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/view/appbar.dart';
import 'package:front/features/shared/view/bill_detail_paragraph_widget.dart';
import 'package:front/features/shared/view/bill_proposer_section_widget.dart';
import 'package:front/features/shared/view/capturable_widget.dart';
import 'package:front/features/shared/view/error.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

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
          data: (billDetail) => _buildBody(billDetail, context),
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

  Widget _buildBody(PreAnnounceBillDetail billDetail, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CaptureAndShareWidget(
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
                          // onPressed: () => _openExternalBrowser(billDetail.preAnnouncementSection.linkUrl!),
                          onPressed: () => _showDisclaimerDialog(context, billDetail.preAnnouncementSection.linkUrl!),
                          child: const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '의견 등록하러 가기',
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
                    // const Text("※ 본 앱은 국회 입법예고 시스템과 직접적인 관련이 없는 비공식 서비스입니다.해당 링크를 통해 국회에서 운영하는 공식 사이트(open.assembly.go.kr)로 이동 가능합니다", style: TextStylePreset.innerContentSubtitle,),
                    if(billDetail.proposerSection != null)
                      BillProposerSectionWidget(billProposerSection: billDetail.proposerSection!)
                  ],
                ),
              )
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          //   color: ColorPalette.background,
          //   child: const Text(
          //     "바로 앱 서비스\n\n ogongchill@googlegroups.com\n\n정보는 국회공공데이터포털(open.aseembly.go.kr)에서 제공된 데이터를 기반으로 하며, \n본 앱은 정부와 관련없는 민간 서비스입니다",
          //     style: TextStylePreset.thumbnailSubtitle,
          //   ),
          // ),
          const DisclaimerWidget(),
        ],
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

  void _showDisclaimerDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("의견 등록 안내", style: TextStylePreset.sectionTitle,),
        backgroundColor: ColorPalette.whitePrimary,
        content: const Text(
          "본 앱은 국회 입법예고 시스템과 직접적인 관련이 없는 비공식 서비스입니다.\n\n"
              "해당 링크는 국회에서 운영하는 공식 사이트(open.assembly.go.kr)로 연결되며, "
              "의견 등록은 사용자께서 해당 공식 페이지에서 직접 진행하셔야 합니다.\n\n"
              "본 앱의 의견 제출 절차를 중개하거나 저장하지 않습니다.",
          style: TextStylePreset.innerContentSubtitle,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // 닫기
            child: const Text("취소", style: TextStylePreset.thumbnailTitle),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              _openExternalBrowser(url);  // 외부 브라우저 열기
            },
            child: const Text("이해했어요", style: TextStylePreset.thumbnailTitle,),
          ),
        ],
      ),
    );
  }
}