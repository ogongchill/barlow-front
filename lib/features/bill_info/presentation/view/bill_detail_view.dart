import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/bill_info/domain/entities/bill_detail.dart';
import 'package:front/features/bill_info/domain/repositories/bill_repository.dart';
import 'package:front/features/bill_info/presentation/view/bill_detail_paragraph_widget.dart';
import 'package:front/features/bill_info/presentation/view/bill_proposer_section_widget.dart';
import 'package:front/features/bill_info/presentation/viewmodel/bill_detail_provider.dart';

class BillDetailView extends ConsumerWidget {

  final BillDetailRepository repository = getIt<BillDetailRepository>();
  final String _billId;

  BillDetailView({super.key, required String billId}) : _billId = billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(getBillDetailFutureProvider(_billId));
    return asyncValue.when(
        data: (billDetail) => _buildScaffold(_createInnerContent(billDetail)),
        error: (err, stack) => Text("something went wrong,,,,"),
        loading: () => Text("isLoading,,,,"));
  }

  Scaffold _buildScaffold(Widget body) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
            color: ColorPalette.innerContent,
            borderRadius: BorderRadius.circular(12)
          ),
          child: body,
        ),
      )
    );
  }

  Widget _createInnerContent(BillDetail billDetail) {
    return Column(
      children: [
          BillDetailParagraphWidget(text: billDetail.detail),
          _createBillProposerSection(billDetail)
        ,
      ]
    );
  }

  Widget _createBillProposerSection(BillDetail billDetail) {
    if(billDetail.proposerSection == null) {
      return Container();
    }
    return BillProposerSectionWidget(billProposerSection: billDetail.proposerSection!);
  }
}
