import 'package:core/storage/secure-storage/token_repository.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:features/settings/domain/entities/user.dart';
import 'package:features/settings/domain/repositories/user_repository.dart';
import 'package:features/signup/domain/entities/guest_signup_info.dart';
import 'package:features/signup/domain/repositories/guest_signup_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GuestSignupUseCase {
  final GuestSignupRepository _signupRepository;
  final TokenRepository _tokenRepository;
  final UserInfoRepository _userInfoRepository;
  final DeviceInfo _deviceInfo;

  GuestSignupUseCase(
    this._signupRepository,
    this._tokenRepository,
    this._userInfoRepository,
    this._deviceInfo,
  );

  /// 게스트 회원가입을 수행한다.
  ///
  /// 1. 서버에 회원가입 요청을 보내 accessToken 을 발급받는다.
  /// 2. 발급된 accessToken 을 로컬에 저장한다.
  /// 3. 사용자 정보(닉네임, role)를 로컬에 저장한다.
  Future<void> execute(GuestSignupInfo info) async {
    final accessToken = await _signupRepository.signUp(info);
    await _tokenRepository.writeAccessToken(accessToken);
    await _userInfoRepository.setUserInfo(
      UserInfo(
        userId: _deviceInfo.deviceId,
        userName: info.nickname,
        role: UserRole.guest,
      ),
    );
  }
}
