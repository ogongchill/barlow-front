import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class CommitteeSubscriptionWidget extends ConsumerWidget {
  final List<CommitteeSubscription> _committeeSubscriptions;

  const CommitteeSubscriptionWidget({super.key, required List<CommitteeSubscription> committeeSubscriptions})
      : _committeeSubscriptions = committeeSubscriptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: ColorPalette.innerContent,
      child: ListView.builder(
        itemCount: _committeeSubscriptions.length,
        itemBuilder: (context, index) {
          final committeeSubscription = _committeeSubscriptions[index];

          return Card(
            color: ColorPalette.innerContent,
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: ListTile(
              title: Text(
                  committeeSubscription.committee.name,
                  style: TextStylePreset.listElement,
              ),
              trailing: _createSubscribeButton(committeeSubscription, ref)
            ),
          );
        },
      ),
    );
  }


  Widget _createSubscribeButton(CommitteeSubscription committeeSubscription, WidgetRef ref) {
    return SizedBox(
      width : 80,
      height: 30,
      child: ElevatedButton(
        onPressed: () async {
          ref.read(toggleCommitteeSubscriptionViewModelProvider).execute(committeeSubscription);
          ref.invalidate(committeeSubscriptionFutureProvider);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: committeeSubscription.isSubscribed
              ? ColorPalette.greyLight
              : ColorPalette.bluePrimary,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(
            committeeSubscription.isSubscribed ? "구독중" : "구독",
            style: TextStylePreset.toggleButton
        ),
      )
    );
  }
}

