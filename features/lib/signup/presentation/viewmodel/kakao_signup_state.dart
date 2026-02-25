import 'package:features/signup/domain/entities/oidc_signup_info.dart';

/// Kakao OIDC 회원가입 버튼 흐름의 UI 상태를 표현한다.
///
/// - [KakaoSignupIdle]       : 초기 대기 상태
/// - [KakaoSignupLoading]    : 카카오 로그인 및 약관 조회 진행 중
/// - [KakaoSignupTermsReady] : idToken 획득 및 약관 목록 로드 완료 — 약관 동의 화면 전환 준비
/// - [KakaoSignupError]      : 오류 발생
sealed class KakaoSignupState {
  const KakaoSignupState();
}

final class KakaoSignupIdle extends KakaoSignupState {
  const KakaoSignupIdle();
}

final class KakaoSignupLoading extends KakaoSignupState {
  const KakaoSignupLoading();
}

final class KakaoSignupTermsReady extends KakaoSignupState {
  final String idToken;
  final List<TermAgreementItem> terms;

  const KakaoSignupTermsReady({
    required this.idToken,
    required this.terms,
  });
}

final class KakaoSignupError extends KakaoSignupState {
  final String message;

  const KakaoSignupError({required this.message});
}
