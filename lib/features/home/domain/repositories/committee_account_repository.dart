import '../entities/committee_account.dart';

abstract class SubscribeCommitteeInfoRepository {

    Future<List<SubscribeCommitteeInfo>> retrieveSubscribedCommittee();
}
