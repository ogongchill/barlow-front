import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("HEADER: ${options.headers}");
    options.extra['startTime'] = DateTime.now(); // 요청 시작 시간 저장
    print('*** Request ***');
    print('--> ${options.method} ${Uri.decodeFull(options.uri.toString())}');
    print('Headers: ${options.headers}');
    if (options.data != null) {
      print('Body: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      print('Query: ${options.queryParameters}');
    }
    print('--> END ${options.method}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra['startTime'] as DateTime?;
    final endTime = DateTime.now();
    if (startTime != null) {
      final duration = endTime.difference(startTime);
      print('*** Response ***');
      print('<-- ${response.statusCode} ${Uri.decodeFull(response.requestOptions.uri.toString())}');
      print('Time: ${duration.inMilliseconds} ms'); // 걸린 시간 출력
      print('Data: ${response.data}');
      print('<-- END HTTP');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('*** Error ***');
    print('<-- ${err.response?.statusCode} ${Uri.decodeFull(err.requestOptions.uri.toString())}');
    print('Error: ${err.error}');
    if (err.response != null) {
      print('Data: ${err.response?.data}');
    }
    print('<-- End error');
    super.onError(err, handler);
  }
}