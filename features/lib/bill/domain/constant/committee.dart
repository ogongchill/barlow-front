import 'package:core/api/constants/committee_param.dart';

enum Committee {

  houseSteering("국회운영위원회", CommitteeParam.houseSteering),
  legislationAndJudiciary("법제사법위원회", CommitteeParam.legislationAndJudiciary),
  nationalPolicy("정무위원회", CommitteeParam.nationalPolicy),
  strategyAndFinance("기획재정위원회", CommitteeParam.strategyAndFinance),
  education("교육위원회", CommitteeParam.education),
  scienceIctBroadcastingAndCommunications("과학기술정보방송통신위원회", CommitteeParam.scienceIctBroadcastingAndCommunications),
  foreignAffairsAndUnification("외교통일위원회", CommitteeParam.foreignAffairsAndUnification),
  nationalDefense("국방위원회", CommitteeParam.nationalDefense),
  publicAdministrationAndSecurity("행정안전위원회", CommitteeParam.publicAdministrationAndSecurity),
  cultureSportsAndTourism("문화체육관광위원회", CommitteeParam.cultureSportsAndTourism),
  agricultureFoodRuralAffairsOceansAndFisheries("농림축산식품해양수산위원회", CommitteeParam.agricultureFoodRuralAffairsOceansAndFisheries),
  tradeIndustryEnergySmesAndStartups("산업통상자원중소벤처기업위원회", CommitteeParam.tradeIndustryEnergySmesAndStartups),
  healthAndWelfare("보건복지위원회", CommitteeParam.healthAndWelfare),
  environmentAndLabor("환경노동위원회", CommitteeParam.environmentAndLabor),
  landInfrastructureAndTransport("국토교통위원회", CommitteeParam.landInfrastructureAndTransport),
  intelligence("정보위원회", CommitteeParam.intelligence),
  genderEqualityFamily("여성가족위원회", CommitteeParam.genderEqualityFamily),
  specialCommitteeOnBudgetAccounts("예산결산특별위원회", CommitteeParam.specialCommitteeOnBudgetAccounts);

  final String value;
  final CommitteeParam param;

  const  Committee(this.value, this.param);

  static Committee findByName(String targetName) {
    return Committee.values
        .firstWhere((value) =>
          value.value == targetName,
          orElse: () => throw StateError("nu such committee name : $targetName")
    );
  }
}