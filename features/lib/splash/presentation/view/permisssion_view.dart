import 'package:design_system/theme/color_palette.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/splash/presentation/viewmodel/permission_check_provider.dart';
import 'package:features/splash/presentation/viewmodel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionView extends ConsumerWidget {

  static const TextStyle _title = TextStyle(
    fontFamily: "gmarketSans",
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w500
  );

  static const TextStyle _header = TextStyle(
      fontFamily: "gmarketSans",
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500
  );

  static const TextStyle _subtitle = TextStyle(
      fontFamily: "gmarketSans",
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500
  );

  static const TextStyle _description = TextStyle(
      fontFamily: "gmarketSans",
      color: ColorPalette.greyDark,
      fontSize: 12,
      fontWeight: FontWeight.w500
  );

  static const TextStyle _buttonAlert = TextStyle(
      fontFamily: "gmarketSans",
      color: Colors.redAccent,
      fontSize: 20,
      fontWeight: FontWeight.w500
  );

  const PermissionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(markAsCheckNotificationPermissionProvider);
    ref.read(requestNotificationPermissionProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(top: 100, left: 40, right: 40),
          child:  Column(
            spacing: 20,
            children: [
              const Text("앱 권한 설정 안내", style: _title,),
              const Text("앱을 실행하기 위해서는 다음의 권한이 필요합니다", style: _header,),
              Container(
                color: ColorPalette.greyLight,
                padding: const EdgeInsets.all(20),
                child: const Column(
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Icon(Icons.notifications),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("알림(선택)", style: _header,),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Text("푸시 알림 수신을 위해 이 기능에 접근합니다.", style: _subtitle,),
                    Text("선택 접근 권한은 허용하지 않아도 해당 기능 외 서비스 이용이 가능합니다", style: _description,)
                  ],
                ),
              ),
              const Text("접근권한 변경 방법", style: _subtitle,),
              const Text("휴대폰 설정 > 앱 또는 어플리케이션 관리 > 권한 (바로가기)", style: _description)
            ],
          ),
      ),
      bottomNavigationBar: TextButton(onPressed: () {
        ref.read(markAsCheckNotificationPermissionProvider)();
        ref.invalidate(appInitializeStateProvider);
        ApplicationNavigatorService.goToSplash();
      },
      child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text("확인", style: _buttonAlert,))
      ),
    );
  }
}