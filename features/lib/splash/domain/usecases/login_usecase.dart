import 'package:core/database/secure-storage/token_repository.dart';
import 'package:features/settings/domain/repositories/user_repository.dart';
import 'package:features/splash/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {

  final AuthRepository _loginRepository;
  final TokenRepository _tokenRepository;
  final UserInfoRepository _userRepository;

  LoginUseCase(this._loginRepository, this._tokenRepository, this._userRepository);

  Future<void> execute() async {
     String token = await _loginRepository.guestLogin();
     await _tokenRepository.writeAccessToken(token);
     await _userRepository.retrieve();
  }
}