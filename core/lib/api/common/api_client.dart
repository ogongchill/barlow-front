import 'package:core/api/api_exception.dart';
import 'package:core/api/common/api_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

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

@LazySingleton()
class ApiClient {

  final Dio _dio;

  // @factoryMethod
  // ApiClient.dev(this._dio);
  //
  // ApiClient({required DioConfig dioConfig, List<Interceptor>? interceptors})
  //   : _dio = Dio(
  //   BaseOptions(
  //       connectTimeout: dioConfig.connectionTimeOut,
  //       receiveTimeout: dioConfig.receiveTimeOut,
  //       baseUrl: dioConfig.hostUrl
  //   )
  // )
  // ..interceptors.addAll(interceptors ?? []);
  ApiClient(this._dio);

  Future<TRes?> request<TReq, TRes>({
    required ApiRoute apiRoute,
    Map<String, dynamic>? params,
    dynamic data,
    required TRes Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      Response response = await _sendRequest(apiRoute, params, Options(extra: {'requiresAuth' : apiRoute.requiresAuth}), data);
      return _parseResponse(response, fromJson);
    } on DioException catch (dioException) {
      int? code = dioException.response?.statusCode;
      String? responseBody = dioException.response?.data.toString();
      String statusCode = code == null ? 'unknown' : code.toString();
      throw ApiException(code: statusCode, message: responseBody ?? dioException.message ?? '');
    } on CheckedFromJsonException catch (jsonException) {
      throw ApiException(code: 'unknown', message: jsonException.message ?? '');
    } on Exception catch(e) {
      throw ApiException(code: 'unknown', message: 'unexpected exception caused by $e');
    }
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
}