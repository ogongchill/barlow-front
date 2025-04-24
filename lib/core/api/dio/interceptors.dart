
import 'package:dio/dio.dart';
import 'package:front/core/database/secure-storage/token_repository.dart';
import 'package:front/core/utils/device_info_manager.dart';

class TokenInterceptor extends Interceptor {

  final TokenRepository _tokenRepository;

  TokenInterceptor({required TokenRepository tokenRepository}) : _tokenRepository = tokenRepository;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await _tokenRepository.readAccessToken();
    if(accessToken == null) {
      throw StateError("has no access token for header : Bearer");
    }
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }
}

class DeviceInfoInterceptor extends Interceptor {

  final DeviceInfo deviceInfo;

  DeviceInfoInterceptor({required this.deviceInfo});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['X-Client-OS'] = deviceInfo.deviceOs;
    options.headers['X-Client-OS-Version'] = deviceInfo.deviceOsVersion;
    options.headers['X-Device-ID'] = deviceInfo.deviceId;
    handler.next(options);
  }
}