import 'package:features/bill/domain/constant/committee.dart';
import 'package:features/bill/domain/entities/committee_profile.dart';

abstract interface class CommitteeProfileRepository {

  Future<CommitteeProfile> retrieve(Committee committee);
}