import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/api_response.dart';
import 'package:front/core/api/dio/dio.dart';

import 'auth_requests.dart';
import 'auth_response.dart';

class AuthRouter {

  final _GuestSignUp _guestSignUp;
  final _GuestLogin _guestLogin;

  AuthRouter({required DioClient dioClientWithoutBearer, required DioClient dioClient})
      : _guestSignUp = _GuestSignUp(dioClientWithoutBearer),
        _guestLogin = _GuestLogin(dioClient);

  ApiRequestEndpoint<SignupRequest, LoginResponse> get guestSignUp => _guestSignUp;
  ApiRequestEndpoint<LoginRequest, LoginResponse> get guestLogin => _guestLogin;
}



class _GuestSignUp extends ApiRequestEndpoint<SignupRequest, LoginResponse>{

  _GuestSignUp(DioClient client): super(
      endpointPath: 'api/v1/auth/guest/signup',
      method: Method.post,
      dioClient: client
  );

  @override
  Future<LoginResponse> send(SignupRequest request) async {
    final response = await dioClient.dio.post(endpointPath, data: request.body);
    Map<String, dynamic> responseBody = response.data;
    ApiResponse<LoginResponse> apiResponse = ApiResponse<LoginResponse>.fromJson(
      responseBody,
          (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data!;
  }
}

class _GuestLogin extends ApiRequestEndpoint<LoginRequest, LoginResponse>{

  _GuestLogin(DioClient client): super(
      endpointPath: 'api/v1/auth/guest/login',
      method: Method.post,
      dioClient: client
  );

  @override
  Future<LoginResponse> send(request) async {
    final response = await dioClient.dio.post(endpointPath, data: request.body);
    Map<String, dynamic> responseBody = response.data;
    ApiResponse<LoginResponse> apiResponse = ApiResponse<LoginResponse>.fromJson(
      responseBody,
          (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data!;
  }
}