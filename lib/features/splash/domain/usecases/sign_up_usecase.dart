import 'package:front/core/database/secure-storage/token_repository.dart';
import 'package:front/core/database/shared-preferences/shared_prefs_application_setting_repository.dart';
import 'package:front/features/settings/domain/entities/user.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';
import 'package:front/features/splash/domain/repositories/auth_repository.dart';
import 'package:uuid/uuid.dart';

class SignupUseCase {

  final AuthRepository _repository;
  final TokenRepository _tokenRepository;
  final AppSettingsRepository _appSettingsRepository;
  final UserInfoRepository _userRepository;

  SignupUseCase(this._repository, this._tokenRepository, this._appSettingsRepository, this._userRepository);

  Future<void> execute(String nickname) async {
    String uuid = const Uuid().v4();
    String accessToken =  await _repository.guestSingUp(uuid, nickname);
    await _tokenRepository.writeAccessToken(accessToken);
    await _userRepository.setUserInfo(UserInfo(
      userId: uuid,
      userName: nickname,
      role: UserRole.guest
    ));
    await _appSettingsRepository.setFirstLaunchChecked();
  }
}
