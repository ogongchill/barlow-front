import 'package:front/features/settings/domain/entities/user.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';

class LoadUserInfoUseCase {

  final UserInfoRepository _repository;

  LoadUserInfoUseCase({required UserInfoRepository repository}) : _repository = repository;

  Future<UserInfo> execute() {
    return _repository.retrieve();
  }
}