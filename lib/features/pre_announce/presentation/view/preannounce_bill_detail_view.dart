import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/pre_announce/domain/entities/preannounce_bill_detail.dart';
import 'package:front/features/pre_announce/presentation/view/d_day_widget.dart';
import 'package:front/features/pre_announce/presentation/viewmodel/preannounce_bill_detail_viewmodel.dart';
import 'package:front/features/shared/view/appbar.dart';
import 'package:front/features/shared/view/bill_detail_paragraph_widget.dart';
import 'package:front/features/shared/view/bill_proposer_section_widget.dart';
import 'package:front/features/shared/view/capturable_widget.dart';
import 'package:front/features/shared/view/error.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class PreAnnounceBillDetailView extends ConsumerWidget {

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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildPreAnnouncementSectionWidget(billDetail),
                BillDetailParagraphWidget(text: billDetail.detail),
                if(billDetail.proposerSection != null)
                  BillProposerSectionWidget(billProposerSection: billDetail.proposerSection!)
              ],
            ),
          )
      ),
    );
  }

  Widget _buildPreAnnouncementSectionWidget(PreAnnounceBillDetail detail) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              DdayWidget(dDay: detail.preAnnouncementSection.dDAy),
              Text(detail.proposerSummary, style: TextStylePreset.billDetailText),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(detail.title, style: TextStylePreset.billDetailHead),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${detail.legislativeBody}", style: TextStylePreset.innerContentSubtitle),
              Text("${DateFormat('yyyy-MM-dd').format(detail.preAnnouncementSection.deadline)}까지", style: TextStylePreset.innerContentSubtitle)
            ],
          )
        ],
      ),
    );
  }
}