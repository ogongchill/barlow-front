import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/splash/domain/usecases/check_notification_permission_permanently_denied_usecase.dart';
import 'package:front/features/splash/presentation/viewmodel/permission_check_provider.dart';

class NotificationPermissionDialog {

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

  static const TextStyle _button = TextStyle(
      fontFamily: "gmarketSans",
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500
  );

  static void show(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(checkNotificationPermissionPermanentlyDeniedProvider);
    asyncValue.when(
        data: (status) {
          if(status != PermissionStatus.granted) {
            _showNotificationPermissionDialog(context, ref);
            return;
          }
          ref.read(requestNotificationPermissionProvider);
        },
        error: (err, stack){ print("ERR:${err}");},
        loading: (){}
    );
  }

  static void _showNotificationPermissionDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: ColorPalette.whitePrimary,
        title: const Column(
          spacing: 20,
          children: [
            SizedBox(height: 30),
            Icon(Icons.notifications_off_rounded, size: 48,),
            Text("알림이 차단되어있어요 :(", style: _header,),
            SizedBox(height: 30),
            Divider()
          ],
        ),
        content: Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("설정을 열고 알림을 권한을 허용하여 정보를 빠르게 받아보세요", style: _subtitle,),
              // SizedBox(height: 30,),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(requestNotificationPermissionProvider);
            } ,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text("설정 열기", style: _button,),
                Icon(Icons.settings, color: Colors.black,),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            } ,
            child: const Text("알림을 켜지 않을래요", style: _button,),
          ),
        ],
      ),
    );
  }
}