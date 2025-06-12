import 'package:features/committee/domain/entities/committee_profile.dart';
import 'package:features/committee/domain/repositories/committee_profile_repository.dart';
import 'package:features/shared/domain/committee.dart';

class FetchCommitteeProfileUseCase {

  final CommitteeProfileRepository _repository;

  FetchCommitteeProfileUseCase({
    required CommitteeProfileRepository repository
  })
    : _repository = repository;

  Future<CommitteeProfile> execute(Committee committee) async {
    return _repository.retrieve(committee);
  }
}