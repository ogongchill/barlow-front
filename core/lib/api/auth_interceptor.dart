import 'package:core/database/secure-storage/token_repository.dart';
import 'package:core/utils/device_info_manager.dart';
import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {

  final TokenRepository _tokenRepository;
  final DeviceInfo _deviceInfo;

  HeaderInterceptor({required TokenRepository tokenRepository, required DeviceInfo deviceInfo})
  : _tokenRepository = tokenRepository,
    _deviceInfo = deviceInfo;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, String> headers = {
      'X-Client-OS': _deviceInfo.deviceOs,
      'X-Client-OS-Version': _deviceInfo.deviceOsVersion,
      'X-Device-ID': _deviceInfo.deviceId,
      'X-App-Version': _deviceInfo.appVersion,
    };
    if(options.extra['requiresAuth'] == true) {
      String? accessToken = await _tokenRepository.readAccessToken();
      headers['Authorization'] = 'Bearer $accessToken';
    }
    options.headers.addAll(headers);
    super.onRequest(options, handler);
  }
}