import 'package:flutter_test/flutter_test.dart';
import 'package:front/core/api/auth/auth_requests.dart';
import 'package:front/core/api/auth/auth_response.dart';
import 'package:front/core/api/auth/auth_router.dart';

import '../core_api_test_config.dart';


void main() {

  test('게스트 로그인 성공', () async {
    final request = LoginRequestBody(
      deviceOs: TestUserInfo.deviceOs,
      deviceId: TestUserInfo.deviceId,
      deviceToken: TestUserInfo.deviceToken,
    );
    final expectedResponse = LoginResponse(accessToken: TestUserInfo.accessToken);
    AuthRouter authRouter = AuthRouter(dioClientWithoutBearer: noBearerClient, dioClient: bearerClient);
    final actual = await authRouter.guestLogin.send(LoginRequest(request));
    expect(actual.accessToken, expectedResponse.accessToken);
  });
}