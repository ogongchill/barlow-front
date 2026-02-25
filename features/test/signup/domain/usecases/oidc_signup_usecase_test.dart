import 'package:core/storage/secure-storage/token_repository.dart';
import 'package:features/settings/domain/entities/user.dart';
import 'package:features/settings/domain/repositories/user_repository.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/repositories/oidc_signup_repository.dart';
import 'package:features/signup/domain/usecases/oidc_signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSignupRepository implements OidcSignupRepository {
  final String? returnToken;
  final Exception? error;
  OidcSignupInfo? capturedInfo;

  _FakeSignupRepository({this.returnToken, this.error});

  @override
  Future<String> signUp(OidcSignupInfo info) async {
    capturedInfo = info;
    if (error != null) throw error!;
    return returnToken!;
  }
}

class _FakeTokenRepository implements TokenRepository {
  String? writtenToken;

  @override
  Future<void> writeAccessToken(String token) async {
    writtenToken = token;
  }

  @override
  Future<String?> readAccessToken() async => writtenToken;

  @override
  Future<void> deleteAccessToken() async {
    writtenToken = null;
  }

  @override
  Future<void> clearAll() async {
    writtenToken = null;
  }
}

class _FakeUserInfoRepository implements UserInfoRepository {
  UserInfo? savedUserInfo;

  @override
  Future<UserInfo> retrieve() async => savedUserInfo!;

  @override
  Future<void> setUserInfo(UserInfo userInfo) async {
    savedUserInfo = userInfo;
  }

  @override
  Future<void> deleteUserInfo() async {
    savedUserInfo = null;
  }
}

void main() {
  const testDeviceId = 'device-123';
  const testNickname = '테스트사용자';
  const testAccessToken = 'server.access.token';

  final testSignupInfo = OidcSignupInfo(
    idToken: 'id.token',
    provider: OidcProvider.kakao,
    termAgreements: const [],
    nickname: testNickname,
    deviceId: testDeviceId,
    deviceToken: 'fcm-token',
    deviceOs: 'android',
  );

  group('OidcSignupUseCase', () {
    test('회원가입 성공 시 accessToken 저장 및 사용자 정보를 저장한다', () async {
      final signupRepo = _FakeSignupRepository(returnToken: testAccessToken);
      final tokenRepo = _FakeTokenRepository();
      final userRepo = _FakeUserInfoRepository();
      final useCase = OidcSignupUseCase(signupRepo, tokenRepo, userRepo);

      await useCase.execute(testSignupInfo);

      expect(tokenRepo.writtenToken, testAccessToken);
      expect(userRepo.savedUserInfo?.userId, testDeviceId);
      expect(userRepo.savedUserInfo?.userName, testNickname);
      expect(userRepo.savedUserInfo?.role, UserRole.realNameVerified);
    });

    test('signUp 이 예외를 던지면 tokenRepository 를 호출하지 않는다', () async {
      final signupRepo = _FakeSignupRepository(error: Exception('서버 오류'));
      final tokenRepo = _FakeTokenRepository();
      final userRepo = _FakeUserInfoRepository();
      final useCase = OidcSignupUseCase(signupRepo, tokenRepo, userRepo);

      await expectLater(
        () => useCase.execute(testSignupInfo),
        throwsException,
      );

      expect(tokenRepo.writtenToken, isNull);
      expect(userRepo.savedUserInfo, isNull);
    });
  });
}
