import 'package:front/features/committee/domain/entities/committee_subscription.dart';

abstract class CommitteeSubscriptionRepository {

  Future<List<CommitteeSubscription>> retrieve();

  Future<void> subscribe(CommitteeSubscription subscribe);

  Future<void> unsubscribe(CommitteeSubscription unsubscribe);
}
