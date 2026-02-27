import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/entities/signup_option.dart';

/// 회원가입 옵션 선택 후 약관 동의 화면 전환까지의 공통 UI 상태.
///
/// - [SignupIdle]       : 초기 대기 상태
/// - [SignupLoading]    : credential 획득 및 약관 조회 진행 중
/// - [SignupTermsReady] : 옵션 및 약관 목록 로드 완료 — 약관 동의 화면 전환 준비
/// - [SignupError]      : 오류 발생
sealed class SignupState {
  const SignupState();
}

final class SignupIdle extends SignupState {
  const SignupIdle();
}

final class SignupLoading extends SignupState {
  const SignupLoading();
}

final class SignupTermsReady extends SignupState {
  final SignupOption option;
  final List<TermAgreementItem> terms;

  const SignupTermsReady({required this.option, required this.terms});
}

final class SignupError extends SignupState {
  final String message;
  const SignupError({required this.message});
}
