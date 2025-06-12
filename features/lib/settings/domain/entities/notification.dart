import 'package:features/shared/domain/committee.dart';

sealed class NotificationType {

  final String name;

  NotificationType(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationType &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class CommitteeNotificationType extends NotificationType {

  CommitteeNotificationType._(Committee committee) : super(committee.value);

  static CommitteeNotificationType houseSteering = CommitteeNotificationType._(Committee.houseSteering);
  static CommitteeNotificationType legislationAndJudiciary = CommitteeNotificationType._(Committee.legislationAndJudiciary);
  static CommitteeNotificationType nationalPolicy = CommitteeNotificationType._(Committee.nationalPolicy);
  static CommitteeNotificationType strategyAndFinance = CommitteeNotificationType._(Committee.strategyAndFinance);
  static CommitteeNotificationType education = CommitteeNotificationType._(Committee.education);
  static CommitteeNotificationType scienceIctBroadcastingAndCommunications = CommitteeNotificationType._(Committee.scienceIctBroadcastingAndCommunications);
  static CommitteeNotificationType foreignAffairsAndUnification = CommitteeNotificationType._(Committee.foreignAffairsAndUnification);
  static CommitteeNotificationType nationalDefense = CommitteeNotificationType._(Committee.nationalDefense);
  static CommitteeNotificationType publicAdministrationAndSecurity = CommitteeNotificationType._(Committee.publicAdministrationAndSecurity);
  static CommitteeNotificationType cultureSportsAndTourism = CommitteeNotificationType._(Committee.cultureSportsAndTourism);
  static CommitteeNotificationType agricultureFoodRuralAffairsOceansAndFisheries = CommitteeNotificationType._(Committee.agricultureFoodRuralAffairsOceansAndFisheries);
  static CommitteeNotificationType tradeIndustryEnergySmesAndStartups = CommitteeNotificationType._(Committee.tradeIndustryEnergySmesAndStartups);
  static CommitteeNotificationType healthAndWelfare = CommitteeNotificationType._(Committee.healthAndWelfare);
  static CommitteeNotificationType environmentAndLabor = CommitteeNotificationType._(Committee.environmentAndLabor);
  static CommitteeNotificationType landInfrastructureAndTransport = CommitteeNotificationType._(Committee.landInfrastructureAndTransport);
  static CommitteeNotificationType intelligence = CommitteeNotificationType._(Committee.intelligence);
  static CommitteeNotificationType genderEqualityFamily = CommitteeNotificationType._(Committee.genderEqualityFamily);
  static CommitteeNotificationType specialCommitteeOnBudgetAccounts = CommitteeNotificationType._(Committee.specialCommitteeOnBudgetAccounts);

  static List<CommitteeNotificationType> getAll() => [
    houseSteering,
    legislationAndJudiciary,
    nationalPolicy,
    strategyAndFinance,
    education,
    scienceIctBroadcastingAndCommunications,
    foreignAffairsAndUnification,
    nationalDefense,
    publicAdministrationAndSecurity,
    cultureSportsAndTourism,
    agricultureFoodRuralAffairsOceansAndFisheries,
    tradeIndustryEnergySmesAndStartups,
    healthAndWelfare,
    environmentAndLabor,
    landInfrastructureAndTransport,
    intelligence,
    genderEqualityFamily,
    specialCommitteeOnBudgetAccounts
  ];

  factory CommitteeNotificationType.of(Committee committee) => CommitteeNotificationType._(committee);
}
