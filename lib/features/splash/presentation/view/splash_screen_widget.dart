import 'package:flutter/material.dart';

class SplashScreenWidget extends StatelessWidget {

  const SplashScreenWidget({super.key});

  /// android 12 + 설정 (splash 아이콘 크기 288 x 288dp)
  /// ios 및 android 11 이하 버전 확인 필요
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/pictures/splash_android_12_바로.png',
          width: 288,
          height: 288,
        ),
      ),
    );
  }
}