import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/text_style_preset.dart';
import 'package:features/bill/domain/entities/bill_detail.dart';
import 'package:features/bill/presentation/viewmodel/bill_detail_provider.dart';
import 'package:features/bill/presentation/widgets/bill_proposer_section_widget.dart';
import 'package:features/bill/presentation/widgets/bill_detail_paragraph_widget.dart';
import 'package:features/shared/presentation/widget/appbar.dart';
import 'package:features/shared/presentation/widget/capturable_widget.dart';
import 'package:features/shared/presentation/widget/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../settings/presentation/widgets/disclaimer_widget.dart';

class BillDetailScreen extends ConsumerWidget {

  final String _title;
  final String? _subtitle;
  final String _billId;

  const BillDetailScreen({super.key, required String billId, required String title, String? subtitle})
      : _billId = billId,
        _title = title,
        _subtitle = subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(getBillDetailFutureProvider(_billId));
    return asyncValue.when(
        data: (billDetail) => _buildScaffold(_createInnerContent(billDetail)),
        error: (err, stack)  {
            print("ERROR: ${err}");
            return _buildError();
          },
        loading: () => _buildSkeletonLoader(context)
    );
  }

  Widget _buildSkeletonLoader(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: TextAppBar(title: _title, subtitle: _subtitle,),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!, // 어두운 회색
        highlightColor: Colors.grey[100]!, // 밝은 회색
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white, // Shimmer가 덮어씌우므로 큰 의미 없음
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }

  Scaffold _buildError() {
    return Scaffold(
        backgroundColor: ColorPalette.background,
        appBar: TextAppBar(title: _title, subtitle: _subtitle,),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.zero
            ),
            child: const SomethingWentWrongWidget(),
          ),
        )
    );
  }

  Widget _buildScaffold(Widget body) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: TextAppBar(title: _title, subtitle: _subtitle,),
      body: SingleChildScrollView(
          child: Container(
              decoration: const BoxDecoration(
                  color: ColorPalette.innerContent,
                  borderRadius: BorderRadius.zero
            ),
            child: Column(
              children: [
                CaptureAndShareWidget(body: body),
                const DisclaimerWidget(),
              ],
            ),
         ),
      ),
    );
  }

  Widget _createInnerContent(BillDetail billDetail) {
    return Container(
      color: ColorPalette.innerContent,
      padding: const EdgeInsets.all(20),
      child: Column(
          children: [
            _createBillThumbnailInfo(billDetail),
            BillDetailParagraphWidget(text: billDetail.detail),
            if(billDetail.proposerSection == null)
              const SizedBox.shrink(),
            if(billDetail.proposerSection != null)
              _createBillProposerSection(billDetail),
          ]
      ),
    );
  }

  _createBillThumbnailInfo(BillDetail billDetail) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 50, top: 20),
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(billDetail.proposerSummary, style: TextStylePreset.billDetailText),
          Text(billDetail.title, style: TextStylePreset.billDetailHead,),
          Text(DateFormat('yyyy-MM-dd').format(billDetail.createdAt), style: TextStylePreset.innerContentSubtitle)
        ],
      )
    );
  }

  Widget _createBillProposerSection(BillDetail billDetail) {
    if(billDetail.proposerSection == null) {
      return Container();
    }
    return BillProposerSectionWidget(billProposerSection: billDetail.proposerSection!);
  }
}
