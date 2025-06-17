import 'package:design_system/icon_utils.dart';
import 'package:features/bill/domain/constant/committee.dart';

class CommitteeIconMapper {

  static const Map<Committee, CommitteeIcons> _map = {
    Committee.houseSteering : CommitteeIcons.houseSteering,
    Committee.legislationAndJudiciary : CommitteeIcons.legislationAndJudiciary,
    Committee.nationalPolicy : CommitteeIcons.nationalPolicy,
    Committee.strategyAndFinance : CommitteeIcons.strategyAndFinance,
    Committee.education : CommitteeIcons.education,
    Committee.scienceIctBroadcastingAndCommunications : CommitteeIcons.scienceIctBroadcastingAndCommunications,
    Committee.foreignAffairsAndUnification : CommitteeIcons.foreignAffairsAndUnification,
    Committee.nationalDefense : CommitteeIcons.nationalDefense,
    Committee.publicAdministrationAndSecurity : CommitteeIcons.publicAdministrationAndSecurity,
    Committee.cultureSportsAndTourism : CommitteeIcons.cultureSportsAndTourism,
    Committee.agricultureFoodRuralAffairsOceansAndFisheries : CommitteeIcons.agricultureFoodRuralAffairsOceansAndFisheries,
    Committee.tradeIndustryEnergySmesAndStartups : CommitteeIcons.tradeIndustryEnergySmesAndStartups,
    Committee.healthAndWelfare : CommitteeIcons.healthAndWelfare,
    Committee.environmentAndLabor : CommitteeIcons.environmentAndLabor,
    Committee.landInfrastructureAndTransport : CommitteeIcons.landInfrastructureAndTransport,
    Committee.intelligence : CommitteeIcons.intelligence,
    Committee.genderEqualityFamily : CommitteeIcons.genderEqualityFamily,
    Committee.specialCommitteeOnBudgetAccounts : CommitteeIcons.specialCommitteeOnBudgetAccounts
  };

  static String getPath(Committee committee) => _map[committee]!.path;
}