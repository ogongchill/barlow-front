import 'package:core/navigation/application_navigation_service.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/test_style_preset.dart';
import 'package:features/committee/domain/entities/committee_subscription.dart';
import 'package:features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class CommitteeSubscriptionWidget extends ConsumerWidget {
  final List<CommitteeSubscription> _committeeSubscriptions;

  const CommitteeSubscriptionWidget({super.key, required List<CommitteeSubscription> committeeSubscriptions})
      : _committeeSubscriptions = committeeSubscriptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: ColorPalette.innerContent,
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListView.builder(
        shrinkWrap: true, // ✅ 높이를 Column에 맞게 자동 조정
        physics: const NeverScrollableScrollPhysics(), // ✅ 부모 스크롤과 충돌 방지
        itemCount: _committeeSubscriptions.length,
        itemBuilder: (context, index) {
          final committeeSubscription = _committeeSubscriptions[index];

          return Card(
            color: ColorPalette.innerContent,
            margin: EdgeInsets.zero,
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: ListTile(
              title: Text(
                committeeSubscription.committee.value,
                style: TextStylePreset.listElement,
              ),
              // trailing: _createSubscribeButton(committeeSubscription, ref),
              trailing: _CommitteeSubscriptionButtonWidget(
                  subscription: committeeSubscription,
                  then: () async {
                    await ref.read(toggleCommitteeSubscriptionViewModelProvider).execute(committeeSubscription);
                    ref.invalidate(committeeSubscriptionFutureProvider);
                  }),
              onTap: () => ApplicationNavigatorService.pushToCommitteeProfile(ref, committeeSubscription.committee),
            ),
          );
        },
      ),
    );
  }
}


class _CommitteeSubscriptionButtonWidget extends ConsumerWidget {

  final CommitteeSubscription _subscription;
  final Function _afterOnPressedFunction;
  final double? _width;
  final double? _height;

  const _CommitteeSubscriptionButtonWidget({
    required CommitteeSubscription subscription,
    required Function then,
    double? width,
    double? height})
      : _subscription = subscription,
        _width = width,
        _height = height,
        _afterOnPressedFunction = then;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFireworkActive = ref.watch(fireworkAnimationProvider(_subscription.committee));
    final isButtonDisabled = ref.watch(subscribeButtonDisabledProvider(_subscription.committee));

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
              ref.read(subscribeButtonDisabledProvider(_subscription.committee).notifier).state = true; // 버튼 비활성화
              if (!_subscription.isSubscribed) {
                ref.read(fireworkAnimationProvider(_subscription.committee).notifier).state = true; // 구독 안되어있을때 "구독"버튼 눌러야만 애니메이션
              }
              _afterOnPressedFunction();
              ref.read(subscribeButtonDisabledProvider(_subscription.committee).notifier).state = false;
            },
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.black26,
              backgroundColor: isButtonDisabled
                  ? ColorPalette.blueLight //  애니메이션이 진행 중이면 버튼 색을 변경
                  : (_subscription.isSubscribed ? ColorPalette.greyLight : ColorPalette.bluePrimary),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            ),
            child: Text(
              _subscription.isSubscribed ? "구독중" : "구독",
              style: TextStylePreset.toggleButton,
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: _width == null ? -2 : (_width - 80) / 2 -2,
          child: isFireworkActive
              ? Lottie.asset(
            'assets/animations/lottie/simple_fireworks.json',
            width: 100,
            height: 100,
            repeat: false, // ✅ 한 번만 실행
            onLoaded: (composition) {
              Future.delayed(composition.duration, () {
                ref.read(fireworkAnimationProvider(_subscription.committee).notifier).state = false;
              });
            },
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}


