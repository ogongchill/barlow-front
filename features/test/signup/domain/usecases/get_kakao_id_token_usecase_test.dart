import 'package:core/oidc/kakao_auth_service.dart';
import 'package:features/signup/domain/usecases/get_kakao_id_token_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeKakaoAuthService implements KakaoAuthService {
  final String? idToken;
  _FakeKakaoAuthService({this.idToken});

  @override
  Future<String?> getIdToken({required bool? forceLogin}) async => idToken;

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}

void main() {
  group('GetKakaoIdTokenUseCase', () {
    test('idToken 이 정상적으로 반환되면 해당 값을 반환한다', () async {
      const expectedToken = 'valid.id.token';
      final useCase = GetKakaoIdTokenUseCase(_FakeKakaoAuthService(idToken: expectedToken));

      final result = await useCase.execute();

      expect(result, expectedToken);
    });

    test('idToken 이 null 이면 StateError 를 던진다', () async {
      final useCase = GetKakaoIdTokenUseCase(_FakeKakaoAuthService(idToken: null));

      expect(() => useCase.execute(), throwsA(isA<StateError>()));
    });
  });
}
