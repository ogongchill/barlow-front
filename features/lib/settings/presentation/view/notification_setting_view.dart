import 'package:design_system/theme/color_palette.dart';
import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/presentation/view/notification_widget.dart';
import 'package:features/settings/presentation/viewmodel/user_reject_provider.dart';
import 'package:features/shared/presentation/widget/appbar.dart';
import 'package:features/shared/presentation/widget/error.dart';
import 'package:features/splash/domain/usecases/check_notification_permission_permanently_denied_usecase.dart';
import 'package:features/splash/presentation/viewmodel/open_app_setting_provider.dart';
import 'package:features/splash/presentation/viewmodel/permission_check_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationSettingView extends ConsumerWidget {

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

  const NotificationSettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rejectStatus = ref.watch(checkUserRejectStatusProvider(UserRejectCategory.notificationPermissionDialog));
    return rejectStatus.when(
        data: (hasRejectDialog) {
          if (!hasRejectDialog) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              show(context, ref);
            });
          }
          return _buildScaffold();
        },
        error: (err, stack) => const SomethingWentWrongWidget(),
        loading: () => _buildScaffold()
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: const TextAppBar(title: "알림 설정"),
      body: SingleChildScrollView(
        child: Container(
          color: ColorPalette.background,
          padding: const EdgeInsets.all(15),
          child: const NotificationWidget(),
        ),
      ),
    );
  }

  void show(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(checkNotificationPermissionStatusProvider);
    asyncValue.when(
        data: (status) {
          if(status != PermissionStatus.granted) {
            _showNotificationPermissionDialog(context, ref);
            return;
          }
        },
        error: (err, stack) => const SomethingWentWrongWidget(),
        loading: (){}
    );
  }

  void _showNotificationPermissionDialog(BuildContext context, WidgetRef ref) {
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
              ref.read(openAppSettingProvider)();
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
              ref.read(markAsRejectProvider)(UserRejectCategory.notificationPermissionDialog);
              Navigator.pop(context);
            } ,
            child: const Text("다시 보지 않기", style: _button,),
          ),
        ],
      ),
    );
  }
}