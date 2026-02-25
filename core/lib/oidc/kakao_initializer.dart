import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';

const String _kakaoNativeAppKey = String.fromEnvironment('KAKAO_NATIVE_APP_KEY');

class KakaoInitializer {

  Future<void> initialize() async {
    KakaoSdk.init(
      nativeAppKey: _kakaoNativeAppKey
    );
  }
}