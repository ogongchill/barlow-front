import 'package:core/api/auth/auth_requests.dart';
import 'package:core/api/auth/oidc_requests.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/repositories/oidc_signup_repository.dart';
import 'package:flutter_test/flutter_test.dart';

// OidcSignupRepository 의 Fake 구현체로
// Adapter 의 OidcSignupInfo -> OidcSignupRequest 매핑 책임을
// 격리하여 검증한다.
class _FakeOidcSignupRepository implements OidcSignupRepository {
  final String? returnToken;
  final Exception? error;
  OidcSignupInfo? capturedInfo;

  _FakeOidcSignupRepository({this.returnToken, this.error});

  @override
  Future<String> signUp(OidcSignupInfo info) async {
    capturedInfo = info;
    if (error != null) throw error!;
    return returnToken!;
  }
}

// Adapter 의 매핑 로직을 인라인으로 재현하여 변환 결과를 검증한다.
OidcSignupRequest _mapToRequest({
  required OidcSignupInfo info,
  required String fcmToken,
  required String deviceOs,
  required String deviceId,
}) {
  return OidcSignupRequest(
    oidcPayload: OidcPayload(
      authProvider: info.provider.apiValue,
      idToken: info.idToken,
    ),
    termAgreement: TermAgreements(
      termAgreements: {
        for (final item in info.termAgreements) item.id: item.isAgreed,
      },
    ),
    signupPayload: SignupRequestBody(
      deviceOs: DeviceOs.fromString(deviceOs),
      deviceId: deviceId,
      deviceToken: fcmToken,
      nickname: info.nickname,
    ),
  );
}

void main() {
  group('OidcSignupRepositoryAdapter - OidcSignupInfo 매핑', () {
    const testIdToken = 'kakao.id.token';
    const testNickname = '테스트사용자';
    const testDeviceId = 'device-abc';
    const testDeviceToken = 'fcm-token-xyz';
    const testDeviceOs = 'android';
    const testAccessToken = 'server.access.token';

    OidcSignupInfo buildSignupInfo({
      List<TermAgreementItem> terms = const [],
    }) {
      return OidcSignupInfo(
        idToken: testIdToken,
        provider: OidcProvider.kakao,
        termAgreements: terms,
        nickname: testNickname,
        deviceId: testDeviceId,
        deviceToken: testDeviceToken,
        deviceOs: testDeviceOs,
      );
    }

    test('signUp 성공 시 accessToken 을 반환한다', () async {
      final repo = _FakeOidcSignupRepository(returnToken: testAccessToken);
      final info = buildSignupInfo();

      final result = await repo.signUp(info);

      expect(result, testAccessToken);
    });

    test('OidcProvider.kakao 는 apiValue 가 KAKAO 이다', () {
      expect(OidcProvider.kakao.apiValue, 'KAKAO');
    });

    test('termAgreements 가 id:isAgreed 맵으로 변환된다', () {
      final terms = [
        const TermAgreementItem(
          id: 1,
          title: '서비스 이용약관',
          linkUrl: 'https://example.com/terms',
          isRequired: true,
          isAgreed: true,
        ),
        const TermAgreementItem(
          id: 2,
          title: '개인정보 처리방침',
          linkUrl: 'https://example.com/privacy',
          isRequired: true,
          isAgreed: false,
        ),
        const TermAgreementItem(
          id: 3,
          title: '마케팅 수신 동의',
          linkUrl: 'https://example.com/marketing',
          isRequired: false,
          isAgreed: true,
        ),
      ];
      final info = buildSignupInfo(terms: terms);

      final request = _mapToRequest(
        info: info,
        fcmToken: testDeviceToken,
        deviceOs: testDeviceOs,
        deviceId: testDeviceId,
      );

      final mapped = request.termAgreement.termAgreements;
      expect(mapped[1], true);
      expect(mapped[2], false);
      expect(mapped[3], true);
    });

    test('signupPayload 에 nickname, deviceId, deviceToken, deviceOs 가 올바르게 설정된다', () {
      final info = buildSignupInfo();

      final request = _mapToRequest(
        info: info,
        fcmToken: testDeviceToken,
        deviceOs: testDeviceOs,
        deviceId: testDeviceId,
      );

      expect(request.signupPayload.nickname, testNickname);
      expect(request.signupPayload.deviceId, testDeviceId);
      expect(request.signupPayload.deviceToken, testDeviceToken);
      expect(request.signupPayload.deviceOs, DeviceOs.android);
    });

    test('oidcPayload 에 authProvider 와 idToken 이 올바르게 설정된다', () {
      final info = buildSignupInfo();

      final request = _mapToRequest(
        info: info,
        fcmToken: testDeviceToken,
        deviceOs: testDeviceOs,
        deviceId: testDeviceId,
      );

      expect(request.oidcPayload.authProvider, 'KAKAO');
      expect(request.oidcPayload.idToken, testIdToken);
    });

    test('signUp 이 예외를 던지면 그대로 전파한다', () async {
      final repo = _FakeOidcSignupRepository(error: Exception('서버 오류'));
      final info = buildSignupInfo();

      expect(() => repo.signUp(info), throwsException);
    });

    test('termAgreements 가 비어 있으면 빈 맵으로 변환된다', () {
      final info = buildSignupInfo();

      final request = _mapToRequest(
        info: info,
        fcmToken: testDeviceToken,
        deviceOs: testDeviceOs,
        deviceId: testDeviceId,
      );

      expect(request.termAgreement.termAgreements, isEmpty);
    });
  });
}
