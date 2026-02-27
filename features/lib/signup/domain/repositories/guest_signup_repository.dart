import 'package:features/signup/domain/entities/guest_signup_info.dart';

abstract interface class GuestSignupRepository {
  /// 게스트 회원가입을 수행하고 서버 발급 accessToken을 반환한다.
  Future<String> signUp(GuestSignupInfo info);
}
