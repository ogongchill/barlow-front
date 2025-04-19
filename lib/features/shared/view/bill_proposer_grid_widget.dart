import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:front/features/shared/domain/bil_detail.dart';
import 'package:front/features/shared/view/bill_proposer_card_widget.dart';
class BillProposerGridWidget extends StatelessWidget {
  final List<BillProposer> billProposers;

  const BillProposerGridWidget({super.key, required this.billProposers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: 1 / 1,
      ),
      itemCount: billProposers.length,
      itemBuilder: (context, index) {
        final proposer = billProposers[index];
        OverlayEntry? overlayEntry;

        return GestureDetector(
          onLongPressStart: (_) {
            overlayEntry = overlayEntry = OverlayEntry(
              builder: (_) => Stack(
                children: [
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1), // 블러 강도 조절
                      child: Container(
                        color: Colors.black26, // 살짝 어두운 반투명 배경
                      ),
                    ),
                  ),
                  Center(
                    child: Material(
                      color: Colors.transparent,
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: BillProposerCardWidget(billProposer: proposer),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
            Overlay.of(context).insert(overlayEntry!);
          },
          onLongPressEnd: (_) {
            overlayEntry?.remove();
            overlayEntry = null;
          },
          child: BillProposerCardWidget(billProposer: proposer),
        );
      },
    );
  }
}
