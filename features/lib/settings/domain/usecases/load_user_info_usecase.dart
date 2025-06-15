import 'package:features/settings/domain/entities/user.dart';
import 'package:features/settings/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadUserInfoUseCase {

  final UserInfoRepository _repository;

  LoadUserInfoUseCase({required UserInfoRepository repository}) : _repository = repository;

  Future<UserInfo> execute() {
    return _repository.retrieve();
  }
}