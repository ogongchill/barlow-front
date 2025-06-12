import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:features/shared/domain/bil_detail.dart';
import 'package:features/shared/view/bill_proposer_card_widget.dart';
import 'package:flutter/material.dart';

class BillProposerGridWidget extends StatefulWidget {
  final List<BillProposer> billProposers;

  const BillProposerGridWidget({super.key, required this.billProposers});

  @override
  State<BillProposerGridWidget> createState() => _BillProposerGridWidgetState();
}

class _BillProposerGridWidgetState extends State<BillProposerGridWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final proposer in widget.billProposers) {
      precacheImage(CachedNetworkImageProvider(proposer.profileImage), context);
    }
  }

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
      itemCount: widget.billProposers.length,
      itemBuilder: (context, index) {
        final proposer = widget.billProposers[index];
        OverlayEntry? overlayEntry;

        return GestureDetector(
          onLongPressStart: (_) {
            overlayEntry = OverlayEntry(
              builder: (_) => Stack(
                children: [
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Container(color: Colors.black26),
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
