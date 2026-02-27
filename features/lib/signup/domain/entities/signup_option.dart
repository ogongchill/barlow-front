/// 회원가입 방식을 표현한다. 추후 OAuth, ID/Password 등으로 확장 가능.
sealed class SignupOption {
  const SignupOption();
}

/// 카카오 OIDC 회원가입. [idToken]은 카카오 SDK에서 발급받은 OIDC id token.
final class KakaoSignupOption extends SignupOption {
  final String idToken;
  const KakaoSignupOption({required this.idToken});
}

/// 게스트 회원가입. 별도 인증 토큰 없이 진행.
final class GuestSignupOption extends SignupOption {
  const GuestSignupOption();
}
