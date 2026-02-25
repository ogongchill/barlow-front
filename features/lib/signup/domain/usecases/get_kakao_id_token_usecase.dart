import 'package:core/oidc/kakao_auth_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetKakaoIdTokenUseCase {

  final KakaoAuthService _kakaoAuthService;

  GetKakaoIdTokenUseCase(this._kakaoAuthService);

  /// 카카오 로그인을 통해 OIDC idToken 을 획득한다.
  ///
  /// idToken 이 null 인 경우 [StateError] 를 던진다.
  /// 카카오 SDK 에서 idToken 은 OIDC 스코프가 부여된 경우에만 발급된다.
  Future<String> execute() async {
    final idToken = await _kakaoAuthService.getIdToken();
    if (idToken == null) {
      throw StateError('카카오 OIDC idToken 이 null 입니다. OIDC 스코프가 부여되었는지 확인하세요.');
    }
    return idToken;
  }
}
