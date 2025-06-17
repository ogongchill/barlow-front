import 'package:features/bill/domain/entities/bill_detail_sections.dart';
import 'package:features/bill/presentation/widgets/bill_proposer_grid_widget.dart';
import 'package:features/bill/presentation/widgets/single_bar_chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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