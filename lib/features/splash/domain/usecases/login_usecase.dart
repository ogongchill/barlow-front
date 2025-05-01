
import 'package:front/core/database/secure-storage/token_repository.dart';
import 'package:front/core/database/shared-preferences/shared_prefs_application_setting_repository.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';
import 'package:front/features/splash/domain/repositories/auth_repository.dart';

class LoginUseCase {

  final AuthRepository _loginRepository;
  final TokenRepository _tokenRepository;
  final AppSettingsRepository _appSettingsRepository;
  final UserInfoRepository _userRepository;

  LoginUseCase(this._loginRepository, this._tokenRepository, this._appSettingsRepository, this._userRepository);

  Future<void> execute() async {
     String token = await _loginRepository.guestLogin();
     await _tokenRepository.writeAccessToken(token);
     await _appSettingsRepository.setLoginStatus(true);
     await _userRepository.retrieve();
  }
}