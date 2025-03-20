import 'package:front/features/committee/domain/entities/committee_account.dart';
import 'package:front/features/shared/domain/committee.dart';

abstract class CommitteeAccountRepository {

  Future<CommitteeAccountInfo> retrieveCommitteeInfo(Committee committee);
}