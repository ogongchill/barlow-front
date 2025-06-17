enum CommitteeParam {

  houseSteering("HOUSE_STEERING"), // 국회운영위원회
  legislationAndJudiciary("LEGISLATION_AND_JUDICIARY"), // 법제사법위원회
  nationalPolicy("NATIONAL_POLICY"), // 정무위원회
  strategyAndFinance("STRATEGY_AND_FINANCE"), // 기획재정위원회
  education("EDUCATION"), // 교육위원회
  scienceIctBroadcastingAndCommunications("SCIENCE_ICT_BROADCASTING_AND_COMMUNICATIONS"), //과학기술정보방송통신위원회
  foreignAffairsAndUnification("FOREIGN_AFFAIRS_AND_UNIFICATION"), // 외교통일위원회
  nationalDefense("NATIONAL_DEFENSE"), // 국방위원회
  publicAdministrationAndSecurity("PUBLIC_ADMINISTRATION_AND_SECURITY"), // 행정안전위원회
  cultureSportsAndTourism("CULTURE_SPORTS_AND_TOURISM"), // 문화체육관광위원회
  agricultureFoodRuralAffairsOceansAndFisheries("AGRICULTURE_FOOD_RURAL_AFFAIRS_OCEANS_AND_FISHERIES"), // 농림축산식품해양수산위원회
  tradeIndustryEnergySmesAndStartups("TRADE_INDUSTRY_ENERGY_SMES_AND_STARTUPS"), // 산업통상자원중소벤처기업위원회
  healthAndWelfare("HEALTH_AND_WELFARE"), // 보건복지위원회
  environmentAndLabor("ENVIRONMENT_AND_LABOR"), // 환경노동위원회
  landInfrastructureAndTransport("LAND_INFRASTRUCTURE_AND_TRANSPORT"), // 국토교통위원회
  intelligence("INTELLIGENCE"), // 정보위원회
  genderEqualityFamily("GENDER_EQUALITY_FAMILY"), // 여성가족위원회
  specialCommitteeOnBudgetAccounts("SPECIAL_COMMITTEE_ON_BUDGET_ACCOUNTS"); // 예산결산특별위원회

  final String value;

  const CommitteeParam(this.value);
}