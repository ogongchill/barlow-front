import 'dart:collection';
import 'dart:math';

import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/domain/repositories/committee_repository.dart';
import 'package:front/features/shared/domain/committee.dart';

class DummyCommitteeSubscriptionRepository implements CommitteeSubscriptionRepository {

  final LinkedHashSet<CommitteeSubscription> _committeeSubscriptions;

  DummyCommitteeSubscriptionRepository({required LinkedHashSet<CommitteeSubscription> committeeSubscriptions})
    : _committeeSubscriptions = committeeSubscriptions;
  
  @override
  Future<List<CommitteeSubscription>> retrieve() async {
    return _committeeSubscriptions.toList();
  }

  @override
  Future<void> subscribe(CommitteeSubscription subscribe) async {
    print("구독 요청 :  ${subscribe.committee.name}");
    _committeeSubscriptions.firstWhere((committeeSubscription) => committeeSubscription.committee == subscribe.committee)
        .subscribe();
    print("POST : subscribe ${subscribe.committee.name}");
    _sendDummyPostRequest();
  }

  @override
  Future<void> unsubscribe(CommitteeSubscription unsubscribe) async {
    print("구독 취시 요청 :  ${unsubscribe.committee.name}");
    _committeeSubscriptions.firstWhere((committeeSubscription) => committeeSubscription.committee == unsubscribe.committee)
        .unSubscribe();
    print("POST : unsubscribe  ${unsubscribe.committee.name}");
    _sendDummyPostRequest();
  }

  Future<void> _sendDummyPostRequest() async{
    await Future.delayed(Duration(seconds: 1));
    print("응답 확인");
  }
}

class DummyCommitteeSubscriptionRepositoryFactory {

  static CommitteeSubscriptionRepository withRandom() {
    return DummyCommitteeSubscriptionRepository(committeeSubscriptions: _createRandom());
  }
}

final List<CommitteeSubscription> _committeeSubscriptions = [
  CommitteeSubscription(committee: Committee.specialCommitteeOnBudgetAccounts, isSubscribed: true),
  CommitteeSubscription(committee: Committee.genderEqualityFamily, isSubscribed: true),
  CommitteeSubscription(committee: Committee.intelligence, isSubscribed: true),
  CommitteeSubscription(committee: Committee.landInfrastructureAndTransport, isSubscribed: true),
  CommitteeSubscription(committee: Committee.environmentAndLabor, isSubscribed: true),
  CommitteeSubscription(committee: Committee.healthAndWelfare, isSubscribed: true),
  CommitteeSubscription(committee: Committee.tradeIndustryEnergySmesAndStartups, isSubscribed: true),
  CommitteeSubscription(committee: Committee.agricultureFoodRuralAffairsOceansAndFisheries, isSubscribed: true),
  CommitteeSubscription(committee: Committee.cultureSportsAndTourism, isSubscribed: true),
  CommitteeSubscription(committee: Committee.publicAdministrationAndSecurity, isSubscribed: true),
  CommitteeSubscription(committee: Committee.nationalDefense, isSubscribed: true),
  CommitteeSubscription(committee: Committee.foreignAffairsAndUnification, isSubscribed: true),
  CommitteeSubscription(committee: Committee.scienceIctBroadcastingAndCommunications, isSubscribed: true),
  CommitteeSubscription(committee: Committee.education, isSubscribed: true),
  CommitteeSubscription(committee: Committee.strategyAndFinance, isSubscribed: true),
  CommitteeSubscription(committee: Committee.nationalPolicy, isSubscribed: true),
  CommitteeSubscription(committee: Committee.legislationAndJudiciary, isSubscribed: true),
  CommitteeSubscription(committee: Committee.houseSteering, isSubscribed: true),
];

LinkedHashSet<CommitteeSubscription> _createRandom() {
  Random random = Random();
  return LinkedHashSet<CommitteeSubscription>.from(
      Committee.values
          .map( (committee) => CommitteeSubscription(committee: committee, isSubscribed: random.nextBool()))
      );
}