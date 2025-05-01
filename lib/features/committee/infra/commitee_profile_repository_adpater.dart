import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/dev/dummy-repository/dummy_cache.dart';
import 'package:front/features/committee/domain/entities/committee_profile.dart';
import 'package:front/features/committee/domain/repositories/committee_profile_repository.dart';
import 'package:front/features/shared/domain/committee.dart';

class CommitteeProfileRepositoryAdapter implements CommitteeProfileRepository {

  final ApiRouter _router;
  final CommitteeNotificationCache _notificationCache;
  final CommitteeSubscriptionCache _subscriptionCache;
  final CommitteeProfileCache _profileCache = CommitteeProfileCache();

  CommitteeProfileRepositoryAdapter(this._router, this._notificationCache, this._subscriptionCache);

  @override
  Future<CommitteeProfile> retrieve(Committee committee) async {
    bool? isSubscriptionEnabled;
    bool? isNotificationEnabled;
    if(_profileCache.hit(committee)) {
      CommitteeProfile cachedProfile = _profileCache.get(committee);
      if(_subscriptionCache.hit(committee)) {
        isSubscriptionEnabled = _subscriptionCache.get(committee);
      }
      if(_notificationCache.hit(committee)) {
        isNotificationEnabled = _notificationCache.get(committee);
      }
      return CommitteeProfile(
          committee: committee,
          description: cachedProfile.description,
          postCount: cachedProfile.postCount,
          subscriberCount: cachedProfile.subscriberCount,
          isSubscribed: isSubscriptionEnabled ?? cachedProfile.isSubscribed,
          isNotificationActive: isNotificationEnabled ?? cachedProfile.isNotificationActive
      );
    }

    final response = await _router.legislationAccountRouter.retrieveProfile(CommitteeLegislationType.of(committee));

    CommitteeProfile profile = CommitteeProfile(
        committee: committee,
        description: response!.description,
        postCount: response.postCount,
        subscriberCount: response.subscriberCount,
        isSubscribed: isSubscriptionEnabled ?? response.isSubscribe,
        isNotificationActive: isNotificationEnabled ?? response.isNotifiable
    );
    _profileCache.add(committee, profile);
    return profile;
  }
}