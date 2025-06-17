import 'package:core/api/auth/auth_requests.dart';
import 'package:core/api/auth/auth_response.dart';
import 'package:core/api/auth/auth_router.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_config.dart';

void main() {

  test('게스트 로그인 성공', () async {
    final request = LoginRequestBody(
      deviceOs: TestUserInfo.deviceOs,
      deviceId: TestUserInfo.deviceId,
      deviceToken: TestUserInfo.deviceToken,
    );
    AuthRouter apiService = AuthRouter(mockClient);
    final expectedResponse = LoginResponse(accessToken: TestUserInfo.accessToken);
    final actual = await apiService.guestLogin(request);
    expect(actual!.accessToken, expectedResponse.accessToken);
  });
}