import 'package:front/features/settings/domain/entities/user_reject.dart';
import 'package:front/features/settings/domain/repositories/user_reject_repository.dart';

class CheckUserRejectStatusUseCase {

  final UserRejectRepository _repository;

  CheckUserRejectStatusUseCase({required UserRejectRepository repository}): _repository = repository;

  Future<bool> execute(UserRejectCategory category) async {
    UserReject? userReject = await _repository.findByCategory(category);
    if(userReject == null) {
      return false;
    }
    bool isExpired = DateTime.now().isAfter(userReject.expiredAt);
    if(isExpired) {
      return false;
    }
    return true;
  }
}