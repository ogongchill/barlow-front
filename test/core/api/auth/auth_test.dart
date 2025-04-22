import 'package:flutter_test/flutter_test.dart';
import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/auth/auth_requests.dart';
import 'package:front/core/api/auth/auth_response.dart';
import 'package:front/core/api/auth/auth_router.dart';

import '../core_api_test_config.dart';


void main() {


  test('게스트 로그인 성공', () async {
    final request = LoginRequest(
      deviceOs: TestUserInfo.deviceOs,
      deviceId: TestUserInfo.deviceId,
      deviceToken: TestUserInfo.deviceToken,
    );
    final expectedResponse = LoginResponse(accessToken: TestUserInfo.accessToken);
    final actual = await ApiRouter.auth.guestLogin.send(request);
    expect(actual.accessToken, expectedResponse.accessToken);
  });
}