import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/domain/repositories/committee_subscription_repository.dart';

class FetchCommitteeSubscriptionUseCase {

  final CommitteeSubscriptionRepository _repository;

  FetchCommitteeSubscriptionUseCase({required CommitteeSubscriptionRepository repository}) : _repository = repository;

  Future<List<CommitteeSubscription>> execute() async {
    return await _repository.retrieve();
  }
}

class ToggleCommitteeSubscriptionUseCase {

  final CommitteeSubscriptionRepository _repository;

  ToggleCommitteeSubscriptionUseCase({required CommitteeSubscriptionRepository repository}) : _repository = repository;

  Future<void> execute(CommitteeSubscription committeeSubscription) async {
    if(committeeSubscription.isSubscribed) {
      await _repository.unsubscribe(committeeSubscription);
      return;
    }
    await _repository.subscribe(committeeSubscription);
  }
}
