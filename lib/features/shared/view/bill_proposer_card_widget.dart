import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/utils/icon_utils.dart';
import 'package:front/features/shared/domain/bil_detail.dart';

class BillProposerCardWidget extends StatelessWidget {

  final BillProposer billProposer;

  const BillProposerCardWidget({super.key, required this.billProposer});

  @override
  Widget build(BuildContext context) {
    PartyCard partyCard = PartyCard.findByParty(billProposer.party);
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: partyCard.getCard(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
                child: Image.network(
                  alignment: Alignment.centerRight,
                  "https://brfree.s3.ap-northeast-2.amazonaws.com/22대_개혁신당_이주영.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          partyCard.getNameTag(),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: constraints.maxHeight * 0.025,
                ),
                child:Text(
                    billProposer.name,
                    style: TextStyle(
                        fontFamily: "gmarketSans",
                        fontWeight: FontWeight.w800,
                        color: ColorPalette.whitePrimary,
                        fontSize: constraints.maxWidth * 0.18
                    )),
              )
          ),
          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Material(
                  elevation: 5,
                  child: billProposer.party.toSvgPicture(constraints.maxHeight * 0.225),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.25),
            ],
          )
        ],
      );
    });
  }
}