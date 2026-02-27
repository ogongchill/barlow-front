import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

@LazySingleton()
class KakaoAuthService {

  static const _channel = MethodChannel('barlow.front/cookie');

  Future<String?> getIdToken({required bool forceLogin}) async {
    OAuthToken oAuthToken;
    final bool isTalkInstalled = await isKakaoTalkInstalled();
    final keyHash = await KakaoSdk.origin; // (주의: 버전에 따라 다름)
    debugPrint('keyHash:${keyHash}');
    if (isTalkInstalled) {
      try {
        forceLogin
          ? oAuthToken = await UserApi.instance.loginWithKakaoAccount(prompts: [Prompt.login])// 매번 비밀번호 입력 강제)
          : oAuthToken = await UserApi.instance.loginWithKakaoTalk();
      } catch (e) {
        debugPrint("error:$e");
        oAuthToken = await UserApi.instance.loginWithKakaoAccount();
      }
    } else {
      oAuthToken = await UserApi.instance.loginWithKakaoAccount();
    }

    debugPrint('카카오 로그인 성공 (accessToken 존재)');
    debugPrint('idToken: ${oAuthToken.idToken}');

    return oAuthToken.idToken;
  }

  Future<void> logOut() async {
    try {
      await UserApi.instance.logout();
    } catch (_) {}

    await _clearAllCookies(); // 이게 완전히 끝난 후 로그인 진행되는지 확인

    debugPrint('쿠키 삭제 완료'); // 여기 찍히고 나서 로그인 호출되는지 체크
  }

  static Future<void> _clearAllCookies() async {
    try {
      await _channel.invokeMethod('clearCookies');
    } catch (e) {
      debugPrint('Cookie clear error: $e');
    }
  }
}