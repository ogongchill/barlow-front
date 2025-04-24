import 'package:front/core/api/auth/auth_router.dart';
import 'package:front/core/api/common/api_request.dart';
import 'package:front/core/api/dio/dio.dart';
import 'package:front/core/api/home/home_router.dart';

enum Method {
  get,
  post,
  put,
  delete,
  patch,
  ;
}

abstract class ApiRequestEndpoint<TReq extends ApiRequest, TRes> {

  final String _endpointPath;
  final Method _method;
  final DioClient _dioClient;

  ApiRequestEndpoint({required String endpointPath, required Method method, required DioClient dioClient})
  : _endpointPath = endpointPath,
    _method = method,
    _dioClient = dioClient;

  Future<TRes> send(TReq request);

  String get endpointPath => _endpointPath;

  DioClient get dioClient => _dioClient;

  Method get method => _method;
}

class ApiRouter {

  final AuthRouter auth;
  final HomeRouter home;

  ApiRouter({required DioClient dioClientWithBearer, required DioClient dioClient})
  : auth = AuthRouter(dioClientWithoutBearer: dioClientWithBearer, dioClient: dioClient),
    home = HomeRouter(dioClient: dioClient);
}