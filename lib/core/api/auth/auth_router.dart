import 'package:front/core/api/common/api_client.dart';

import 'auth_requests.dart';
import 'auth_response.dart';

class AuthRouter {

  static const ApiRoute guestLoginRoute = ApiRoute(
      path: 'api/v1/auth/guest/login',
      method: HttpMethod.post,
      requiresAuth: false
  );
  static const ApiRoute guestSignUpRoute = ApiRoute(
      path: 'api/v1/auth/guest/signup',
      method: HttpMethod.post,
      requiresAuth: false
  );

  final ApiClient _apiClient;

  AuthRouter(this._apiClient);

  Future<LoginResponse> guestSingUp(SignupRequestBody requestBody) => _apiClient.request(
      apiRoute: guestSignUpRoute,
      fromJson: (json) => LoginResponse.fromJson(json),
      data: requestBody.toJson()
  );

  Future<LoginResponse> guestLogin(LoginRequestBody requestBody) => _apiClient.request(
      apiRoute: guestLoginRoute,
      fromJson: (json) => LoginResponse.fromJson(json),
      data: requestBody.toJson()
  );
}
