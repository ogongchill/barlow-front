import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/entities/signup_option.dart';

/// 약관 동의 화면의 UI 상태를 표현한다.
///
/// - [TermAgreementIdle]    : 약관 목록 보유, 사용자 입력 대기 중
/// - [TermAgreementLoading] : SignupUseCase 실행 중
/// - [TermAgreementSuccess] : 회원가입 완료
/// - [TermAgreementError]   : 오류 발생
sealed class TermAgreementState {
  const TermAgreementState();
}

final class TermAgreementIdle extends TermAgreementState {
  final SignupOption option;
  final List<TermAgreementItem> terms;

  const TermAgreementIdle({
    required this.option,
    required this.terms,
  });

  /// 필수 약관이 하나 이상 존재하고, 모두 동의된 경우에만 true를 반환한다.
  bool get canSubmit {
    final requiredTerms = terms.where((t) => t.isRequired).toList();
    if (requiredTerms.isEmpty) return false;
    return requiredTerms.every((t) => t.isAgreed);
  }

  /// 전체 약관이 모두 동의된 상태인지 여부.
  bool get isAllAgreed => terms.isNotEmpty && terms.every((t) => t.isAgreed);

  TermAgreementIdle copyWith({
    SignupOption? option,
    List<TermAgreementItem>? terms,
  }) {
    return TermAgreementIdle(
      option: option ?? this.option,
      terms: terms ?? this.terms,
    );
  }
}

final class TermAgreementLoading extends TermAgreementState {
  const TermAgreementLoading();
}

final class TermAgreementSuccess extends TermAgreementState {
  const TermAgreementSuccess();
}

final class TermAgreementError extends TermAgreementState {
  final String message;

  const TermAgreementError({required this.message});
}
