import 'package:core/api/constants/committee_param.dart';
import 'package:core/utils/icon_utils.dart';

enum Committee {

  houseSteering("국회운영위원회", CommitteeIcon.houseSteering, CommitteeParam.houseSteering),
  legislationAndJudiciary("법제사법위원회", CommitteeIcon.legislationAndJudiciary, CommitteeParam.legislationAndJudiciary),
  nationalPolicy("정무위원회", CommitteeIcon.nationalPolicy, CommitteeParam.nationalPolicy),
  strategyAndFinance("기획재정위원회", CommitteeIcon.strategyAndFinance, CommitteeParam.strategyAndFinance),
  education("교육위원회", CommitteeIcon.education, CommitteeParam.education),
  scienceIctBroadcastingAndCommunications("과학기술정보방송통신위원회", CommitteeIcon.scienceIctBroadcastingAndCommunications, CommitteeParam.scienceIctBroadcastingAndCommunications),
  foreignAffairsAndUnification("외교통일위원회", CommitteeIcon.foreignAffairsAndUnification, CommitteeParam.foreignAffairsAndUnification),
  nationalDefense("국방위원회", CommitteeIcon.nationalDefense, CommitteeParam.nationalDefense),
  publicAdministrationAndSecurity("행정안전위원회", CommitteeIcon.publicAdministrationAndSecurity, CommitteeParam.publicAdministrationAndSecurity),
  cultureSportsAndTourism("문화체육관광위원회", CommitteeIcon.cultureSportsAndTourism, CommitteeParam.cultureSportsAndTourism),
  agricultureFoodRuralAffairsOceansAndFisheries("농림축산식품해양수산위원회", CommitteeIcon.agricultureFoodRuralAffairsOceansAndFisheries, CommitteeParam.agricultureFoodRuralAffairsOceansAndFisheries),
  tradeIndustryEnergySmesAndStartups("산업통상자원중소벤처기업위원회", CommitteeIcon.tradeIndustryEnergySmesAndStartups, CommitteeParam.tradeIndustryEnergySmesAndStartups),
  healthAndWelfare("보건복지위원회", CommitteeIcon.healthAndWelfare, CommitteeParam.healthAndWelfare),
  environmentAndLabor("환경노동위원회", CommitteeIcon.environmentAndLabor, CommitteeParam.environmentAndLabor),
  landInfrastructureAndTransport("국토교통위원회", CommitteeIcon.landInfrastructureAndTransport, CommitteeParam.landInfrastructureAndTransport),
  intelligence("정보위원회", CommitteeIcon.intelligence, CommitteeParam.intelligence),
  genderEqualityFamily("여성가족위원회", CommitteeIcon.genderEqualityFamily, CommitteeParam.genderEqualityFamily),
  specialCommitteeOnBudgetAccounts("예산결산특별위원회", CommitteeIcon.specialCommitteeOnBudgetAccounts, CommitteeParam.specialCommitteeOnBudgetAccounts);

  final CommitteeIcon icon;
  final String value;
  final CommitteeParam param;

  const  Committee(this.value, this.icon, this.param);

  static Committee findByName(String targetName) {
    return Committee.values
        .firstWhere((value) =>
          value.value == targetName,
          orElse: () => throw StateError("nu such committee name : $targetName")
    );
  }

  String camelToUpperUnderscore() {
    final regex = RegExp(r'(?<=[a-z])[A-Z]');
    final withUnderscores = name.replaceAllMapped(regex, (match) => '_${match.group(0)}');
    return withUnderscores.toUpperCase();
  }
}