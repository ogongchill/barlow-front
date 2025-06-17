import 'package:design_system/svgs/card_svg.dart';
import 'package:features/bill/domain/constant/party.dart';

class PartyCardMapper {

  static const Map<Party, PartyCard> _iconMap = {
    Party.reform : PartyCard.reform,
    Party.peoplePower : PartyCard.peoplePower,
    Party.basicIncome : PartyCard.basicIncome,
    Party.democratic : PartyCard.democratic,
    Party.socialDemocratic : PartyCard.socialDemocratic,
    Party.progressive : PartyCard.progressive,
    Party.rebuildingKorea : PartyCard.rebuildingKorea,
    Party.independent : PartyCard.independent,
  };

  static String backgroundOf(Party party) => _iconMap[party]!.background;

  static String nameTagOf(Party party) => _iconMap[party]!.nameTag;
}