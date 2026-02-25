import 'package:core/dependency/dependency_container.dart';
import 'package:features/signup/domain/usecases/fetch_active_terms_usecase.dart';
import 'package:features/signup/domain/usecases/get_kakao_id_token_usecase.dart';
import 'package:features/signup/presentation/viewmodel/kakao_signup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kakaoSignupProvider =
    NotifierProvider<KakaoSignupNotifier, KakaoSignupState>(
  KakaoSignupNotifier.new,
);

/// Kakao OIDC 회원가입 버튼 탭 이후 흐름을 관리하는 Notifier.
///
/// 흐름:
///   1. 카카오 로그인 → idToken 획득
///   2. 활성 약관 목록 조회
///   3. 약관 동의 화면 전환 준비 상태([KakaoSignupTermsReady])로 전이
///
/// UI는 [KakaoSignupTermsReady] 상태를 감지하여 약관 동의 화면으로 이동한다.
class KakaoSignupNotifier extends Notifier<KakaoSignupState> {
  @override
  KakaoSignupState build() => const KakaoSignupIdle();

  /// 카카오 로그인 버튼 탭 이벤트 핸들러.
  ///
  /// 이미 [KakaoSignupLoading] 상태이면 중복 실행을 방지한다.
  Future<void> onKakaoLoginButtonTapped() async {
    if (state is KakaoSignupLoading) return;

    state = const KakaoSignupLoading();

    try {
      final idToken =
          await dependencyContainer<GetKakaoIdTokenUseCase>().execute();
      final terms =
          await dependencyContainer<FetchActiveTermsUseCase>().execute();

      state = KakaoSignupTermsReady(idToken: idToken, terms: terms);
    } catch (e) {
      state = KakaoSignupError(message: e.toString());
    }
  }

  /// 오류 확인 후 다시 초기 상태로 되돌린다.
  void resetToIdle() {
    state = const KakaoSignupIdle();
  }
}
