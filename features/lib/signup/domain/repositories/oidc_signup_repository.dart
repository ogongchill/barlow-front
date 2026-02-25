import 'package:features/signup/domain/entities/oidc_signup_info.dart';

abstract interface class OidcSignupRepository {

  /// OIDC 회원가입을 수행하고 서버 발급 accessToken을 반환한다.
  Future<String> signUp(OidcSignupInfo info);
}
