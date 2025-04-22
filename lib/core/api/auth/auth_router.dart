import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/api_response.dart';
import 'package:front/core/api/dio.dart';

import 'auth_requests.dart';
import 'auth_response.dart';

class AuthRouter {
  static final AuthRouter instance = AuthRouter._internal();

  AuthRouter._internal();

  static final _guestSignUp = _GuestSignUp();
  static final _guestLogin = _GuestLogin();

  ApiRequestEndpoint<SignupRequest, LoginResponse> get guestSignUp => _guestSignUp;
  ApiRequestEndpoint<LoginRequest, LoginResponse> get guestLogin => _guestLogin;
}



class _GuestSignUp extends ApiRequestEndpoint<SignupRequest, LoginResponse>{

  _GuestSignUp(): super(
      endpointPath: 'api/v1/auth/guest/signup',
      method: Method.post
  );

  @override
  Future<LoginResponse> send(request) async {
    final response = await DioClient.testServerClient.post(endpointPath, data: request.toJson());
    Map<String, dynamic> responseBody = response.data;
    ApiResponse<LoginResponse> apiResponse = ApiResponse<LoginResponse>.fromJson(
      responseBody,
          (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data!;
  }
}

class _GuestLogin extends ApiRequestEndpoint<LoginRequest, LoginResponse>{

  _GuestLogin(): super(
      endpointPath: 'api/v1/auth/guest/login',
      method: Method.post
  );

  @override
  Future<LoginResponse> send(request) async {
    final response = await DioClient.testServerClient.post(endpointPath, data: request.toJson());
    Map<String, dynamic> responseBody = response.data;
    ApiResponse<LoginResponse> apiResponse = ApiResponse<LoginResponse>.fromJson(
      responseBody,
          (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data!;
  }
}