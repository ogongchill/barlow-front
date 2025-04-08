import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/features/shared/view/bill_proposer_grid_widget.dart';
import 'package:front/features/shared/view/single_bar_chart_widget.dart';
import 'package:front/features/shared/domain/bil_detail.dart';

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