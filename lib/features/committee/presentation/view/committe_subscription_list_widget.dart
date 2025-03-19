import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';
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
                committeeSubscription.committee.name,
                style: TextStylePreset.listElement,
              ),
              trailing: _createSubscribeButton(committeeSubscription, ref),
              onTap: () => print("clicked ${committeeSubscription.committee}"),
            ),
          );
        },
      ),
    );
  }


  Widget _createSubscribeButton(CommitteeSubscription committeeSubscription, WidgetRef ref) {
    final isFireworkActive = ref.watch(fireworkAnimationProvider(committeeSubscription.committee));
    final isButtonDisabled = ref.watch(subscribeButtonDisabledProvider(committeeSubscription.committee));

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: 80,
          height: 30,
          child: ElevatedButton(
            onPressed: isButtonDisabled
                ? null // ✅ 애니메이션 중에는 클릭 불가능
                : () async {
              ref.read(subscribeButtonDisabledProvider(committeeSubscription.committee).notifier).state = true; // 버튼 비활성화

              if (!committeeSubscription.isSubscribed) {
                ref.read(fireworkAnimationProvider(committeeSubscription.committee).notifier).state = true;
              }

              await ref.read(toggleCommitteeSubscriptionViewModelProvider).execute(committeeSubscription);
              ref.invalidate(committeeSubscriptionFutureProvider);
              ref.read(subscribeButtonDisabledProvider(committeeSubscription.committee).notifier).state = false;
            },
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.black26,
              backgroundColor: isButtonDisabled
                  ? Colors.grey // ✅ 애니메이션이 진행 중이면 버튼 색을 변경
                  : (committeeSubscription.isSubscribed ? ColorPalette.greyLight : ColorPalette.bluePrimary),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
            child: Text(
              committeeSubscription.isSubscribed ? "구독중" : "구독",
              style: TextStylePreset.toggleButton,
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: -2,
          child: isFireworkActive
              ? Lottie.asset(
            'assets/animations/lottie/simple_fireworks.json',
            width: 100,
            height: 100,
            repeat: false, // ✅ 한 번만 실행
            onLoaded: (composition) {
              Future.delayed(composition.duration, () {
                ref.read(fireworkAnimationProvider(committeeSubscription.committee).notifier).state = false;
              });
            },
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

