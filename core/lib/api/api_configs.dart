import 'package:core/api/auth_interceptor.dart';
import 'package:core/api/dio_configs.dart';
import 'package:core/api/logger_interceptor.dart';
import 'package:core/dependency/environment.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioConfigModule {

  @LazySingleton(env: [Env.dev])
  Dio get dioDev =>  Dio(
      BaseOptions(
          connectTimeout: testServerConfig.connectionTimeOut,
          receiveTimeout: testServerConfig.receiveTimeOut,
          baseUrl: testServerConfig.hostUrl
      )
  ).. interceptors.addAll([LoggerInterceptor(), GetIt.instance<HeaderInterceptor>()]);

  @LazySingleton(env: [Env.prod])
  Dio get dioProd =>  Dio(
      BaseOptions(
          connectTimeout: testServerConfig.connectionTimeOut,
          receiveTimeout: testServerConfig.receiveTimeOut,
          baseUrl: testServerConfig.hostUrl
      )
  ).. interceptors.addAll([GetIt.instance<HeaderInterceptor>()]);
}