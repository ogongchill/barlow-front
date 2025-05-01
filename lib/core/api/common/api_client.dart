import 'package:dio/dio.dart';
import 'package:front/core/api/common/api_response.dart';
import 'package:front/core/api/dio/dio_configs.dart';
import 'package:front/core/database/secure-storage/token_repository.dart';
import 'package:front/core/utils/device_info_manager.dart';

enum HttpMethod { get, post, put, delete, patch }

class ApiRoute {
  final String path;
  final HttpMethod method;
  final bool requiresAuth;

  const ApiRoute({
    required this.path,
    required this.method,
    this.requiresAuth = true
  });
}

class ApiClient {
  final Dio _dio;
  final TokenRepository _tokenRepository;
  final DeviceInfo _deviceInfo;

  ApiClient({required DioConfig dioConfig, required DeviceInfo deviceInfo, required TokenRepository tokenRepository, List<Interceptor>? interceptors})
    : _dio = Dio(
    BaseOptions(
      connectTimeout: dioConfig.connectionTimeOut,
      receiveTimeout: dioConfig.receiveTimeOut,
      baseUrl: dioConfig.hostUrl
     )
    )
    ..interceptors.addAll(interceptors ?? []),
    _tokenRepository = tokenRepository,
    _deviceInfo = deviceInfo;

  Future<TRes?> request<TReq, TRes>({
    required ApiRoute apiRoute,
    Map<String, dynamic>? params,
    dynamic data,
    required TRes Function(Map<String, dynamic>) fromJson,
  }) async {
    Options options = await _createHeaders(apiRoute);
    Response response = await _sendRequest(apiRoute, params, options, data);

    return _parseResponse(response, fromJson);
  }

  TRes? _parseResponse<TRes>(Response response, TRes Function(Map<String, dynamic>) fromJson) {
    ApiResponse<TRes> apiResponse = ApiResponse<TRes>.fromJson(
      response.data,
          (json) => fromJson(json as Map<String, dynamic>),
    );

    return apiResponse.data;
  }

  Future<Response<dynamic>> _sendRequest(ApiRoute apiRoute, Map<String, dynamic>? params, Options options, data) async {
     switch (apiRoute.method) {
      case HttpMethod.get:
        return await _dio.get(apiRoute.path, queryParameters: params, options: options);
      case HttpMethod.post:
        return await _dio.post(apiRoute.path, data: data, options: options);
      case HttpMethod.put:
        return await _dio.put(apiRoute.path, data: data, options: options);
      case HttpMethod.delete:
        return await _dio.delete(apiRoute.path, queryParameters: params, data: data, options: options);
      case HttpMethod.patch:
        return await _dio.patch(apiRoute.path, data: data, options: options);
    }
  }

  Future<Options> _createHeaders(ApiRoute apiRoute) async {
    late final Map<String, String> headers = {
      'X-Client-OS': _deviceInfo.deviceOs,
      'X-Client-OS-Version': _deviceInfo.deviceOsVersion,
      'X-Device-ID': _deviceInfo.deviceId,
    };

    if (apiRoute.requiresAuth) {
      final accessToken = await _tokenRepository.readAccessToken();
      headers['Authorization'] = 'Bearer $accessToken';
    }
    final options = Options(headers: headers);
    return options;
  }
}
