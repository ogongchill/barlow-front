import 'package:core/api/auth_interceptor.dart';
import 'package:core/api/logger_interceptor.dart';
import 'package:core/api/auth/auth_requests.dart';
import 'package:core/api/common/api_client.dart';
import 'package:core/api/dio_configs.dart';
import 'package:core/storage/secure-storage/token_repository.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:dio/dio.dart';

class TestUserInfo {
  static const deviceOs = DeviceOs.android;
  static const deviceId = "DUMMY_DEVICE_ID";
  static const deviceToken = "DUMMY_FCM_TOKEN";
  static const nickname = "DUMMY_USER";
  static const accessToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJiYXJsb3ctY29yZS1hdXRoIiwibWVtYmVyTm8iOjYwLCJyb2xlIjoiR1VFU1QifQ.BJuT2O0tuTRv59Rn2OKMKc-tDktwvUie0sbAY4siKg3isqclBMu9JPdOG5HjrEr-AXx9rsmCBqGqjuataVRzhi6aZBoZWupyomqHcJCfwf1IeHlIXMwxNbKpO8jRFCHLXck0mwQQobbGjcUih8uO5UvJG7E2WEee1cQqxosvdz4Soz8JF-p8MAuy3c_rLQcNZjwQV_19kgkKjs0vrRf46c0RmCT7tfUXYom8KJYzWSxN44LG8dU0ljEGiZ4ksdXEk2r8GRVkkzYdXSlyZq73upCizq7kkKiRgpzsCv9J1gkaDBRkekZDyEer9-iMqXHGfrPAhudX9A-t1ur6NSJipg";
}

final ApiClient mockClient = ApiClient(
    Dio(
        BaseOptions(
            connectTimeout: testServerConfig.connectionTimeOut,
            receiveTimeout: testServerConfig.receiveTimeOut,
            baseUrl: testServerConfig.hostUrl
        )
    ).. interceptors.addAll([LoggerInterceptor(), mockHeaderInterceptor])
);

final HeaderInterceptor mockHeaderInterceptor = HeaderInterceptor(
    tokenRepository: MockTokenRepository(),
    deviceInfo: MockAndroidDeviceInfo()
);

final DioConfig testServerConfig = DioConfig(
    hostUrl: 'http://43.201.132.160:8080/',
    connectionTimeOut: const Duration(seconds: 10),
    receiveTimeOut: const Duration(seconds: 10)
);

class MockAndroidDeviceInfo implements DeviceInfo {

  @override
  String get deviceId => "test-device-id";

  @override
  String get deviceOs => "android";

  @override
  String get deviceOsVersion => "21";

  @override
  String get appVersion => "1.0.0-alpha";
}

class MockIosDeviceInfo implements DeviceInfo {
  @override
  String get deviceId => "test-device-id";

  @override
  String get deviceOs => "ios";

  @override
  String get deviceOsVersion => "21";

  @override
  String get appVersion => "1.0.0-alpha";
}

class MockTokenRepository implements TokenRepository {

  @override
  Future<void> clearAll() async {
    print('clearAll() called');
  }

  @override
  Future<void> deleteAccessToken() {
    throw UnimplementedError();
  }

  @override
  Future<String?> readAccessToken() async {
    return TestUserInfo.accessToken;
  }

  @override
  Future<void> writeAccessToken(String token) {
    throw UnimplementedError();
  }
}