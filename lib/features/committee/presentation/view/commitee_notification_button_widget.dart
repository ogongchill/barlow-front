import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/domain/entities/committe_notification.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';
import 'package:lottie/lottie.dart';


class CommitteeNotificationButtonWidget extends ConsumerWidget {

  final CommitteeNotification _notification;
  final Function _afterOnPressedFunction;
  final double? _width;
  final double? _height;

  const CommitteeNotificationButtonWidget({
    super.key,
    required CommitteeNotification notification,
    required Function then,
    double? width,
    double? height})
      : _notification = notification,
        _width = width,
        _height = height,
        _afterOnPressedFunction = then;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnimationActive = ref.watch(notificationToggleAnimationProvider(_notification.committee));
    final isButtonDisabled = ref.watch(notificationButtonDisabledProvider(_notification.committee));

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: _width ?? 80,
          height: _height ?? 30,
          child: ElevatedButton(
            onPressed: isButtonDisabled
                ? null // ✅ 애니메이션 중에는 클릭 불가능
                : () async {
              ref.read(notificationButtonDisabledProvider(_notification.committee).notifier).state = true; // 버튼 비활성화
              if (!_notification.isActive) {
                ref.read(notificationToggleAnimationProvider(_notification.committee).notifier).state = true; // 구독 안되어있을때 "구독"버튼 눌러야만 애니메이션
              }
              _afterOnPressedFunction();
              ref.read(notificationButtonDisabledProvider(_notification.committee).notifier).state = false;
            },
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.black26,
              backgroundColor: ColorPalette.greyLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
            child: _notification.isActive
                  ? Icon(Icons.notifications_off_rounded, color: ColorPalette.whitePrimary)
                  : Icon(Icons.notifications_active_rounded, color: ColorPalette.orangePrimary),
          ),
        ),
        Positioned(
          top: -20,
          left: _width == null ? -2 : (_width - 80) / 2 -2,
          child: isAnimationActive
              ? Lottie.asset(
            'assets/animations/lottie/simple_fireworks.json',
            width: 100,
            height: 100,
            repeat: false, // ✅ 한 번만 실행
            onLoaded: (composition) {
              Future.delayed(composition.duration, () {
                ref.read(notificationToggleAnimationProvider(_notification.committee).notifier).state = false;
              });
            },
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
