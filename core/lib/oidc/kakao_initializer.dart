import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

const String _kakaoNativeAppKey = String.fromEnvironment('KAKAO_NATIVE_APP_KEY');

class KakaoInitializer {

  Future<void> initialize() async {
    KakaoSdk.init(
      nativeAppKey: _kakaoNativeAppKey
    );
  }
}