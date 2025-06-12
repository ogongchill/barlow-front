import 'package:features/shared/domain/bil_detail.dart';
import 'package:features/shared/view/single_bar_chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bill_proposer_grid_widget.dart';

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