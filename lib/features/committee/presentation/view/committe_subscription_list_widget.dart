import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/presentation/view/committee_subscription_button_widget.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';

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
              trailing: CommitteeSubscriptionButtonWidget(
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

