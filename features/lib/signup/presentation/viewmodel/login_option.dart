/// 로그인 방식 옵션.
///
/// 추후 다른 로그인 방식(Apple, Google 등)을 추가할 때 이 sealed class를 확장한다.
sealed class LoginOption {
  const LoginOption();
}

final class KakaoLoginOption extends LoginOption {
  const KakaoLoginOption();
}
