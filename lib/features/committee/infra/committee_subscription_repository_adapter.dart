import 'package:dio/dio.dart';
import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/core/database/cache.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/domain/repositories/committee_subscription_repository.dart';
import 'package:front/features/shared/domain/committee.dart';

class CommitteeSubscriptionRepositoryAdapter implements CommitteeSubscriptionRepository {

  final ApiRouter _router;
  final CommitteeSubscriptionCache _cache;

  CommitteeSubscriptionRepositoryAdapter(this._router, this._cache);

  @override
  Future<List<CommitteeSubscription>> retrieve() async {
    if(_cache.hasAll()) {
      List<CommitteeSubscription> subscriptionCache = _cache.getAll();
      subscriptionCache.sort((a, b) => a.committee.value.compareTo(b.committee.value));
      return subscriptionCache;
    }
    final response = await _router.legislationAccountRouter.retrieveCommitteeAccounts();
    List<CommitteeSubscription> subscriptions = response!.accounts.map((account) =>
        CommitteeSubscription(
            committee: Committee.findByName(account.accountName),
            isSubscribed: account.isSubscribed
        )
    ).toList();

    subscriptions.sort((a, b) => a.committee.value.compareTo(b.committee.value));

    _cache.addAll(subscriptions);
    return subscriptions;
  }

  @override
  Future<void> subscribe(CommitteeSubscription subscribe) async {
    if(_cache.hit(subscribe.committee)) {
      _cache.add(subscribe.committee, true);
    }
    try {
      await _router.legislationAccountRouter
          .activateSubscription(
          CommitteeLegislationType.of(subscribe.committee));
    } on DioException catch (e) {
      if(e.response!.statusCode == 409) { // 이미 구독된 상태
        return;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> unsubscribe(CommitteeSubscription unsubscribe) async {
    _cache.add(unsubscribe.committee, false);
    try {
      await _router.legislationAccountRouter
          .deactivateSubscription(
          CommitteeLegislationType.of(unsubscribe.committee));
    } on DioException catch (e) {
      if(e.response!.statusCode == 409) { // 이미 구독된 상태
        return;
      } else {
        rethrow;
      }
    }
  }
}