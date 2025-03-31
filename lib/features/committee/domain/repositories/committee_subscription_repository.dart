import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/shared/domain/committee.dart';

abstract class CommitteeSubscriptionRepository {

  Future<List<CommitteeSubscription>> retrieve();

  Future<CommitteeSubscription> retrieveByCommittee(Committee committee);

  Future<void> subscribe(CommitteeSubscription subscribe);

  Future<void> unsubscribe(CommitteeSubscription unsubscribe);
}
