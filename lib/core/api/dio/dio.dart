
import 'package:dio/dio.dart';
import 'package:front/core/api/dio/dio_configs.dart';

class DioClient {

  final DioConfig dioConfig;
  final List<Interceptor> interceptors;
  final Dio _dio;

  DioClient({
    required this.dioConfig,
    required this.interceptors,
  }) : _dio = Dio(
      BaseOptions(
          baseUrl: dioConfig.hostUrl,
          connectTimeout: dioConfig.connectionTimeOut,
          receiveTimeout: dioConfig.receiveTimeOut
          )
       )
        ..interceptors.addAll(interceptors);

  Dio get dio => _dio;
}

