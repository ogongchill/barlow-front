import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoAuthService {

  Future<String?> getIdToken() async {
    OAuthToken oAuthToken;
    final bool isTalkInstalled = await isKakaoTalkInstalled();

    if (isTalkInstalled) {
      try {
        oAuthToken = await UserApi.instance.loginWithKakaoTalk();
      } catch (e) {
        oAuthToken = await UserApi.instance.loginWithKakaoAccount();
      }
    } else {
      oAuthToken = await UserApi.instance.loginWithKakaoAccount();
    }

    debugPrint('카카오 로그인 성공 (accessToken 존재)');
    debugPrint('accessToken: ${oAuthToken.accessToken}');

    return oAuthToken.idToken;
  }
}