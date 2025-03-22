import 'dart:math';

import 'package:front/dev/dummy-repository/dummy_cache.dart';
import 'package:front/features/committee/domain/entities/committee_profile.dart';
import 'package:front/features/committee/domain/repositories/committee_profile_repository.dart';
import 'package:front/features/shared/domain/committee.dart';

class DummyCommitteeProfileRepository implements CommitteeProfileRepository {

  static const ttl = Duration(milliseconds: 100000);
  final List<CommitteeProfile> _profileSamples;
  final CommitteeProfileCache _cache = CommitteeProfileCache();
  final CommitteeNotificationCache _notificationCache;
  final CommitteeSubscriptionCache _subscriptionCache;

  DummyCommitteeProfileRepository({
    required List<CommitteeProfile> profiles,
    required CommitteeNotificationCache notificationCache,
    required CommitteeSubscriptionCache subscriptionCache
  })
    : _profileSamples = profiles,
      _notificationCache = notificationCache,
      _subscriptionCache = subscriptionCache;

  @override
  Future<CommitteeProfile> retrieve(Committee committee) async {
    if(_cache.hit(committee)) {
      print("fetch committee profile from cache..");
      CommitteeProfile cachedProfile = _cache.get(committee);
      final results = await Future.wait([
        Future.value(_notificationCache.hit(committee) ? _notificationCache.get(committee) : cachedProfile.isNotificationActive),
        Future.value(_subscriptionCache.hit(committee) ? _subscriptionCache.get(committee) : cachedProfile.isSubscribed)
      ]);
      CommitteeProfile updatedFromCache = CommitteeProfile(
          committee: committee,
          description: cachedProfile.description,
          postCount: cachedProfile.postCount,
          subscriberCount: cachedProfile.subscriberCount,
          isSubscribed: results[1],
          isNotificationActive: results[0]
      );
      _cache.add(committee, updatedFromCache);
      return updatedFromCache;
    }
    print("GET : fetching profile samples from api....");
    await Future.delayed(Duration(milliseconds: 500));
    CommitteeProfile fetchedProfile = _profileSamples.firstWhere((committeeProfile) => committeeProfile.committee == committee);
    _cache.add(committee, fetchedProfile);
    return fetchedProfile;
  }
}

class DummyCommitteeProfileRepositoryFactory {

  static const String _descriptionSample = """
법제·사법에 관한 국회의 의사결정기능을 실질적으로 수행
탄핵 소추에 관한 사항과 법률안·국회 규칙안의 체계·형식과 자구의 심사에 관한 사항도 관장""";
  static final Random _random = Random();

  static CommitteeProfileRepository withRandom({
    required CommitteeNotificationCache notificationCache,
    required CommitteeSubscriptionCache subscriptionCache}) {
    return DummyCommitteeProfileRepository(
        notificationCache: notificationCache,
        subscriptionCache: subscriptionCache,
        profiles: _createRandom()
    );
  }

  static List<CommitteeProfile> _createRandom() {
    return Committee.values
        .map((committee) => CommitteeProfile(
        committee: committee,
        description: _descriptionSample,
        postCount: _random.nextInt(10000),
        subscriberCount: _random.nextInt(10000),
        isSubscribed: _random.nextBool(),
        isNotificationActive: _random.nextBool())
    ).toList();
  }
}