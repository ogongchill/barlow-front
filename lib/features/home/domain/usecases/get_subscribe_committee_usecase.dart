import '../entities/committee_account.dart';
import '../repositories/committee_account_repository.dart';

class GetSubscribeCommitteeUseCase {

  final SubscribeCommitteeInfoRepository _repository;

  GetSubscribeCommitteeUseCase(this._repository);

  Future<List<SubscribeCommitteeInfo>> fetch() {
    return _repository.retrieveSubscribedCommittee();
  }
}