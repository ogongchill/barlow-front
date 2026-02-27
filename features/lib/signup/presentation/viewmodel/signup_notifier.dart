import 'package:core/api/api_exception.dart';
import 'package:core/dependency/dependency_container.dart';
import 'package:features/signup/domain/entities/signup_option.dart';
import 'package:features/signup/domain/usecases/fetch_active_terms_usecase.dart';
import 'package:features/signup/domain/usecases/get_kakao_id_token_usecase.dart';
import 'package:features/signup/presentation/viewmodel/signup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupProvider =
    NotifierProvider<SignupNotifier, SignupState>(SignupNotifier.new);

/// 회원가입 옵션 선택 후 약관 동의 화면 전환까지의 공통 흐름을 관리한다.
///
/// 흐름:
///   1. 사용자가 옵션(카카오/게스트) 선택
///   2. 옵션별 credential 획득 + 약관 목록 조회
///   3. [SignupTermsReady]로 전이 → UI가 약관 동의 화면으로 이동
class SignupNotifier extends Notifier<SignupState> {
  @override
  SignupState build() => const SignupIdle();

  /// 카카오 OIDC 로그인 → idToken 획득 → 약관 조회.
  Future<void> startKakaoSignup() async {
    if (state is SignupLoading) return;
    state = const SignupLoading();
    try {
      final idToken =
          await dependencyContainer<GetKakaoIdTokenUseCase>().execute();
      final terms =
          await dependencyContainer<FetchActiveTermsUseCase>().execute();
      state = SignupTermsReady(
        option: KakaoSignupOption(idToken: idToken),
        terms: terms,
      );
    } catch (e) {
      state = SignupError(message: e is ApiException ? e.message : e.toString());
    }
  }

  /// 게스트 회원가입 → 약관 조회 (별도 credential 없음).
  Future<void> startGuestSignup() async {
    if (state is SignupLoading) return;
    state = const SignupLoading();
    try {
      final terms =
          await dependencyContainer<FetchActiveTermsUseCase>().execute();
      state = SignupTermsReady(
        option: const GuestSignupOption(),
        terms: terms,
      );
    } catch (e) {
      state = SignupError(message: e is ApiException ? e.message : e.toString());
    }
  }

  /// 오류 확인 후 다시 초기 상태로 되돌린다.
  void resetToIdle() => state = const SignupIdle();
}
