import 'package:front/core/api/auth/auth_router.dart';

enum Method {
  get,
  post,
  put,
  delete,
  patch,
  ;
}

abstract class ApiRequestEndpoint<TReq, TRes> {

  final String endpointPath;
  final Method method;

  ApiRequestEndpoint({required this.endpointPath, required this.method});

  Future<TRes> send(TReq request);
}

class ApiRouter {

  static AuthRouter auth = AuthRouter.instance;
}