import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/settings/presentation/view/notification_widget.dart';
import 'package:front/features/shared/view/appbar.dart';

class NotificationSettingView extends StatelessWidget {

  const NotificationSettingView({super.key});

  @override
  Widget build(BuildContext context) {
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
}