import 'package:features/bill/domain/entities/committee_subscription.dart';
import 'package:features/bill/domain/repositories/committee_subscription_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchCommitteeSubscriptionUseCase {

  final CommitteeSubscriptionRepository _repository;

  FetchCommitteeSubscriptionUseCase({required CommitteeSubscriptionRepository repository}) : _repository = repository;

  Future<List<CommitteeSubscription>> execute() async {
    return await _repository.retrieve();
  }
}

@injectable
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
