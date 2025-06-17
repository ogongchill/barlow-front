import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:features/bill/domain/entities/bill_detail_sections.dart';
import 'package:features/bill/presentation/mapper/party_card_mapper.dart';
import 'package:features/bill/presentation/mapper/party_icon_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/imgs/image_assets.dart';

class BillProposerCardWidget extends StatelessWidget {

  final BillProposer billProposer;

  const BillProposerCardWidget({super.key, required this.billProposer});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(PartyCardMapper.backgroundOf(billProposer.party)),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
                child: CachedNetworkImage(
                  imageUrl: billProposer.profileImage,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                  errorWidget: (context, url, error) => Image.asset(
                    ImageAssets.defaultProfileImagePath,
                    alignment: Alignment.centerRight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SvgPicture.asset(PartyCardMapper.nameTagOf(billProposer.party)),
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
              Material(
                elevation: 5,
                child: SvgPicture.asset(
                  PartyIconMapper.getPath(billProposer.party),
                  width: constraints.maxHeight * 0.225,
                  height: constraints.maxHeight * 0.225,
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