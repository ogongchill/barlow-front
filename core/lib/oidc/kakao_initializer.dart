import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';

class KakaoInitializer {

  Future<void> initialize() async {
    KakaoSdk.init(
      nativeAppKey: "7c84ea3bc121d1c003c9daa9b147b1ed"
    );
  }
}