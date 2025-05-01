import 'package:front/features/committee/domain/entities/committee_profile.dart';
import 'package:front/features/shared/domain/committee.dart';

abstract interface class CommitteeProfileRepository {

  Future<CommitteeProfile> retrieve(Committee committee);
}