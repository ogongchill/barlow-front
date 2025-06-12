import 'dart:collection';
import 'dart:math';

import 'package:core/database/cache.dart';
import 'package:features/committee/domain/entities/committee_subscription.dart';
import 'package:features/committee/domain/repositories/committee_subscription_repository.dart';
import 'package:features/shared/domain/committee.dart';

class DummyCommitteeSubscriptionRepository implements CommitteeSubscriptionRepository {

  final LinkedHashSet<CommitteeSubscription> _committeeSubscriptions;
  final CommitteeSubscriptionCache _subscriptionCache;

  DummyCommitteeSubscriptionRepository({
    required LinkedHashSet<CommitteeSubscription> committeeSubscriptions,
    required CommitteeSubscriptionCache subscriptionCache
  })
    : _committeeSubscriptions = committeeSubscriptions,
      _subscriptionCache = subscriptionCache;
  
  @override
  Future<List<CommitteeSubscription>> retrieve() async {
    if(_subscriptionCache.hasAll()) {
      return _subscriptionCache.getAll();
    }
    print("fetching,,,,,");
    List<CommitteeSubscription> fetched = _committeeSubscriptions.toList();
    _subscriptionCache.addAll(fetched);
    return _committeeSubscriptions.toList();
  }

  @override
  Future<void> subscribe(CommitteeSubscription subscribe) async {
    print("구독 요청 :  ${subscribe.committee.value}");
    _subscriptionCache.add(subscribe.committee, true);
    print("POST : subscribe ${subscribe.committee.value}");
    _committeeSubscriptions.firstWhere((committeeSubscription) => committeeSubscription.committee == subscribe.committee)
        .subscribe();
    _sendDummyPostRequest();
  }

  @override
  Future<void> unsubscribe(CommitteeSubscription unsubscribe) async {
    print("구독 취시 요청 :  ${unsubscribe.committee.value}");
    _subscriptionCache.add(unsubscribe.committee, false);
    print("POST : unsubscribe  ${unsubscribe.committee.value}");
    _committeeSubscriptions.firstWhere((committeeSubscription) => committeeSubscription.committee == unsubscribe.committee)
        .unSubscribe();
    _sendDummyPostRequest();
  }

  Future<void> _sendDummyPostRequest() async{
    await Future.delayed(Duration(seconds: 1));
    print("응답 확인");
  }

  Future<CommitteeSubscription> retrieveByCommittee(Committee committee) async {
    if(_subscriptionCache.hit(committee)) {
      return CommitteeSubscription(committee: committee, isSubscribed: _subscriptionCache.get(committee));
    }
    retrieve();
    return CommitteeSubscription(committee: committee, isSubscribed: _subscriptionCache.get(committee));
  }
}

class DummyCommitteeSubscriptionRepositoryFactory {

  static CommitteeSubscriptionRepository withRandom({required CommitteeSubscriptionCache subscriptionCache}) {
    return DummyCommitteeSubscriptionRepository(committeeSubscriptions: _createRandom(), subscriptionCache: subscriptionCache);
  }
}

LinkedHashSet<CommitteeSubscription> _createRandom() {
  Random random = Random();
  return LinkedHashSet<CommitteeSubscription>.from(
      Committee.values
          .map( (committee) => CommitteeSubscription(committee: committee, isSubscribed: random.nextBool()))
  );
}