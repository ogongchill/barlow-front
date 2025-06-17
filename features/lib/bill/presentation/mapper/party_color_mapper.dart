import 'dart:ui';

import 'package:design_system/theme/color_palette.dart';
import 'package:features/bill/domain/constant/party.dart';

class PartyColorMapper {

  static const Map<Party, Color> _partyColorMap = {
    Party.reform : ColorPalette.reformOrange,
    Party.peoplePower : ColorPalette.peoplePowerRed,
    Party.basicIncome : ColorPalette.basicIncomeMint,
    Party.democratic : ColorPalette.democraticBlue,
    Party.socialDemocratic : ColorPalette.socialDemocraticOrange,
    Party.progressive : ColorPalette.progressivePurple,
    Party.rebuildingKorea : ColorPalette.rebuildingKoreaBlue,
    Party.independent : ColorPalette.independent,
  };

  static Color getColorOf(Party party) => _partyColorMap[party]!;
}