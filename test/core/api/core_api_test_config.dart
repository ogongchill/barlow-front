import 'package:dio/dio.dart';
import 'package:front/core/api/auth/auth_requests.dart';
import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/dio/dio_configs.dart';
import 'package:front/core/database/secure-storage/token_repository.dart';
import 'package:front/core/utils/device_info_manager.dart';

class TestUserInfo {
  static const deviceOs = DeviceOs.android;
  static const deviceId = "test-id-android3";
  static const deviceToken = "dODGXw36TKKWz2LuPbXOin:APA91bGY3xYMFszpjeMlH6DUbzw6FRDhug_Lpjl5-v8gXEZl9NtUzZiEJtAVeSyAau8iUkPl-RbSLVSgrvb4C3w2Fa5o53zMoUs4IJipKIzRH2bUEsxF8a4";
  static const nickname = "test-user-nickname";
  static const accessToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJiYXJsb3ctY29yZS1hdXRoIiwibWVtYmVyTm8iOjgsInJvbGUiOiJHVUVTVCJ9.mBAfmIS9mB_ua5_zdj-EqWPzsgMfd0BRfDLACBzVWgumBJmSty3Mzp0wazNMO8lghC4Se6qvDFsSChd9ZLu71goyqWFuOUUyKkHL2aVCPkGviac9YCDlAxeYeb8TTie8J4Dyn5cWkhBhalm3VnQybcPyhIgtn-dHDHi1DbrEAxBnFrzIx1ZsW7Gr5HZ9YibHSx-Vgg3lYz8N1edSbhZ9RNdQZVe426o7QRxiXfBjNcozvzZ3mitOucTxgy4JTXMrfsHDisUKk85Q7P8rjxwPvNxv5mbslr319aMCnwsUw_UfUqmRFqe1MByHL7eLYe37o7ZIObu2p8YtSElS6L7Fsw";
}

final ApiClient mockClient = ApiClient(
    dioConfig: testServerConfig,
    deviceInfo: MockAndroidDeviceInfo(),
    tokenRepository: MockTokenRepository(),
    interceptors: [LoggerInterceptor()]
);

class LoggerInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
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
    print('*** Response ***');
    print('<-- ${response.statusCode} ${Uri.decodeFull(response.requestOptions.uri.toString())}');
    print('Headers: ${response.headers.map}');
    print('Data: ${response.data}');
    print('<-- END HTTP');
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

final DioConfig testServerConfig = DioConfig(
    hostUrl: 'http://43.201.132.160:8080/',
    connectionTimeOut: const Duration(seconds: 10),
    receiveTimeOut: const Duration(seconds: 10)
);

class MockAndroidDeviceInfo implements DeviceInfo {
  @override
  // TODO: implement deviceId
  String get deviceId => "test-device-id";

  @override
  // TODO: implement deviceOs
  String get deviceOs => "android";

  @override
  // TODO: implement deviceOsVersion
  String get deviceOsVersion => "21";
}

class MockIosDeviceInfo implements DeviceInfo {
  @override
  // TODO: implement deviceId
  String get deviceId => "test-device-id";

  @override
  // TODO: implement deviceOs
  String get deviceOs => "ios";

  @override
  // TODO: implement deviceOsVersion
  String get deviceOsVersion => "21";
}

class MockTokenRepository implements TokenRepository {

  @override
  Future<void> clearAll() async {
    print('clearAll() called');
  }

  @override
  Future<void> deleteAccessToken() {
    // TODO: implement deleteAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRefreshToken() {
    // TODO: implement deleteRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<String?> readAccessToken() async {
    return TestUserInfo.accessToken;
  }

  @override
  Future<String?> readRefreshToken() {
    // TODO: implement readRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> writeAccessToken(String token) {
    // TODO: implement writeAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> writeRefreshToken(String token) {
    // TODO: implement writeRefreshToken
    throw UnimplementedError();
  }
}