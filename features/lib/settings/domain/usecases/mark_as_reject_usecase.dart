import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/domain/repositories/user_reject_repository.dart';

class MarkAsRejectUseCase {

  static final _maxExpiredAt = DateTime.utc(9999, 12, 31, 23, 59, 59);
  final UserRejectRepository _repository;

  MarkAsRejectUseCase({required UserRejectRepository repository}): _repository = repository;

  Future<void> execute(UserRejectCategory category) async {
    await _repository.markAsReject(category, _maxExpiredAt);
  }
}