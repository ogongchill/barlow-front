import 'package:design_system/icon_utils.dart';
import 'package:features/bill/domain/constant/party.dart';

class PartyIconMapper {

  static const Map<Party, PartyIcons> _iconMap = {
    Party.reform : PartyIcons.reformParty,
    Party.peoplePower : PartyIcons.peoplePowerParty,
    Party.basicIncome : PartyIcons.basicIncomeParty,
    Party.democratic : PartyIcons.democraticParty,
    Party.socialDemocratic : PartyIcons.socialDemocraticParty,
    Party.progressive : PartyIcons.progressiveParty,
    Party.rebuildingKorea : PartyIcons.rebuildingKoreaParty,
    Party.independent : PartyIcons.independent,
  };

  static String getPath(Party party) => _iconMap[party]!.path;
}