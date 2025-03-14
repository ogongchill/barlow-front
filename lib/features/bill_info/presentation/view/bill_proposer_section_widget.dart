import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/features/bill_info/domain/entities/bill_detail.dart';
import 'package:front/features/bill_info/presentation/view/bill_proposer_grid_widget.dart';
import 'package:front/features/bill_info/presentation/view/single_bar_chart_widget.dart';

class BillProposerSectionWidget extends StatelessWidget {

  final BillProposerSection _billProposerSection;

  const BillProposerSectionWidget({super.key, required BillProposerSection billProposerSection})
    : _billProposerSection = billProposerSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          SingleBarChart(data: _billProposerSection.billProposerRate.value),
          BillProposerGridWidget(billProposers: _billProposerSection.billProposer)
      ],
    );
  }
}