import 'package:front/core/utils/icon_utils.dart';

enum Committee {

  houseSteering("국회운영위원회", CommitteeIcon.houseSteering),
  legislationAndJudiciary("법제사법위원회", CommitteeIcon.legislationAndJudiciary),
  nationalPolicy("정무위원회", CommitteeIcon.nationalPolicy),
  strategyAndFinance("기획재정위원회", CommitteeIcon.strategyAndFinance),
  education("교육위원회", CommitteeIcon.education),
  scienceIctBroadcastingAndCommunications("과학기술정보방송통신위원회", CommitteeIcon.scienceIctBroadcastingAndCommunications),
  foreignAffairsAndUnification("외교통일위원회", CommitteeIcon.foreignAffairsAndUnification),
  nationalDefense("국방위원회", CommitteeIcon.nationalDefense),
  publicAdministrationAndSecurity("행정안전위원회", CommitteeIcon.publicAdministrationAndSecurity),
  cultureSportsAndTourism("문화체육관광위원회", CommitteeIcon.cultureSportsAndTourism),
  agricultureFoodRuralAffairsOceansAndFisheries("농림축산식품해양수산위원회", CommitteeIcon.agricultureFoodRuralAffairsOceansAndFisheries),
  tradeIndustryEnergySmesAndStartups("산업통상자원중소벤처기업위원회", CommitteeIcon.tradeIndustryEnergySmesAndStartups),
  healthAndWelfare("보건복지위원회", CommitteeIcon.healthAndWelfare),
  environmentAndLabor("환경노동위원회", CommitteeIcon.environmentAndLabor),
  landInfrastructureAndTransport("국토교통위원회", CommitteeIcon.landInfrastructureAndTransport),
  intelligence("정보위원회", CommitteeIcon.intelligence),
  genderEqualityFamily("여성가족위원회", CommitteeIcon.genderEqualityFamily),
  specialCommitteeOnBudgetAccounts("예산결산특별위원회", CommitteeIcon.specialCommitteeOnBudgetAccounts);

  final CommitteeIcon icon;
  final String name;

  const  Committee(this.name, this.icon);

  static Committee findByName(String targetName) {
    return Committee.values
        .firstWhere((value) =>
          value.name == targetName,
          orElse: () => throw StateError("nu such committee name : $targetName")
    );
  }
}