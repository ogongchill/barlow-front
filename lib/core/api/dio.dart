import 'package:dio/dio.dart';

class DioClient {

  static Dio testServerClient = Dio(
      BaseOptions(
        baseUrl: 'http://43.201.132.160:8080/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10)
      )
  );
}