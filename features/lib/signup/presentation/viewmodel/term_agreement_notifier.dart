import 'package:core/dependency/dependency_container.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/usecases/oidc_signup_usecase.dart';
import 'package:features/signup/presentation/viewmodel/term_agreement_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final termAgreementProvider =
    NotifierProvider<TermAgreementNotifier, TermAgreementState>(
  TermAgreementNotifier.new,
);

/// 약관 동의 화면의 상태를 관리하는 Notifier.
///
/// 흐름:
///   1. UI 진입 시 [initialize]를 호출하여 idToken 과 약관 목록을 주입한다.
///   2. 사용자가 [toggleTerm] / [toggleAll] 로 동의 여부를 선택한다.
///   3. 필수 약관이 모두 동의되면 [TermAgreementIdle.canSubmit]이 true가 된다.
///   4. [submit] 호출 시 [OidcSignupUseCase]를 실행하고 결과에 따라 상태가 전이된다.
///
/// UI는 [TermAgreementSuccess] 상태를 감지하여 다음 화면으로 이동한다.
class TermAgreementNotifier extends Notifier<TermAgreementState> {
  @override
  TermAgreementState build() => const TermAgreementIdle(idToken: '', terms: []);

  /// KakaoSignupTermsReady 에서 전달받은 idToken 과 약관 목록으로 상태를 초기화한다.
  ///
  /// 약관 동의 화면 진입 시 반드시 한 번 호출해야 한다.
  void initialize(String idToken, List<TermAgreementItem> terms) {
    state = TermAgreementIdle(idToken: idToken, terms: terms);
  }

  /// 특정 약관 항목의 동의 여부를 반전시킨다.
  ///
  /// [TermAgreementIdle] 상태가 아닌 경우 무시된다.
  void toggleTerm(int termId) {
    final current = state;
    if (current is! TermAgreementIdle) return;

    final updatedTerms = current.terms.map((term) {
      if (term.id == termId) return term.copyWith(isAgreed: !term.isAgreed);
      return term;
    }).toList();

    state = current.copyWith(terms: updatedTerms);
  }

  /// 전체 약관의 동의 여부를 토글한다.
  ///
  /// 현재 전체 동의 상태이면 전체 해제, 그렇지 않으면 전체 동의로 전환한다.
  /// [TermAgreementIdle] 상태가 아닌 경우 무시된다.
  void toggleAll() {
    final current = state;
    if (current is! TermAgreementIdle) return;

    final targetAgreed = !current.isAllAgreed;
    final updatedTerms =
        current.terms.map((term) => term.copyWith(isAgreed: targetAgreed)).toList();

    state = current.copyWith(terms: updatedTerms);
  }

  /// OidcSignupUseCase 를 실행하여 회원가입을 완료한다.
  ///
  /// [TermAgreementIdle.canSubmit]이 false 이거나 이미 [TermAgreementLoading] 상태이면 무시된다.
  ///
  /// [provider] 는 OIDC 제공자 (기본값: [OidcProvider.kakao]).
  Future<void> submit({
    required String nickname,
    required String deviceId,
    required String deviceToken,
    required String deviceOs,
    OidcProvider provider = OidcProvider.kakao,
  }) async {
    final current = state;
    if (current is! TermAgreementIdle) return;
    if (!current.canSubmit) return;

    state = const TermAgreementLoading();

    try {
      final info = OidcSignupInfo(
        idToken: current.idToken,
        provider: provider,
        termAgreements: current.terms,
        nickname: nickname,
        deviceId: deviceId,
        deviceToken: deviceToken,
        deviceOs: deviceOs,
      );

      await dependencyContainer<OidcSignupUseCase>().execute(info);

      state = const TermAgreementSuccess();
    } catch (e) {
      state = TermAgreementError(message: e.toString());
    }
  }

  /// 오류 확인 후 다시 대기 상태로 되돌린다.
  ///
  /// [TermAgreementError] 상태가 아닌 경우 무시된다.
  void resetToIdle() {
    final current = state;
    if (current is! TermAgreementError) return;
    state = const TermAgreementIdle(idToken: '', terms: []);
  }
}
