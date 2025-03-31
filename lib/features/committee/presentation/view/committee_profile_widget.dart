import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/committee/domain/entities/committe_notification.dart';
import 'package:front/features/committee/domain/entities/committee_profile.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/presentation/view/commitee_notification_button_widget.dart';
import 'package:front/features/committee/presentation/view/committee_subscription_button_widget.dart';
import 'package:front/features/committee/presentation/viewmodel/commitee_profile_viewmodel.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_notificaction_provider.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features//shared/view/error.dart';
import 'package:shimmer/shimmer.dart';

class CommitteeProfileWidget extends ConsumerWidget {

  static const TextStyle _profileCountStyle = TextStyle(
      fontFamily: "GmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.black
  );
  static const TextStyle _profileDescriptionStyle = TextStyle(
      fontFamily: "GmarketSans",
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: ColorPalette.textContent
  );
  static const TextStyle _profileCountDescriptionStyle = TextStyle(
      fontFamily: "GmarketSans",
      fontWeight: FontWeight.w300,
      fontSize: 12,
      color: ColorPalette.textContent
  );

  final Committee _committee;

  const CommitteeProfileWidget(this._committee, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final committeeProfile = ref.watch(committeeProfileFutureProvider(_committee));
    return committeeProfile.when(
      data: (profile) => _buildProfileUI(profile, ref),
      error: (err, stack) => const SomethingWentWrongWidget(),
      loading: () => _buildLoading(ref),
    );
  }


  Widget _buildProfileUI(CommitteeProfile profile, WidgetRef ref) {
    final subscription = CommitteeSubscription(committee: profile.committee, isSubscribed: profile.isSubscribed);
    final notification = CommitteeNotification(committee: profile.committee, isActive: profile.isNotificationActive);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: ColorPalette.greyLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: profile.committee.icon.toSvgPicture(size: 60),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const SizedBox(height: 30),
                        Text("${profile.postCount}", style: _profileCountStyle),
                      ],
                    )
                   ,
                    const SizedBox(
                      width: 60,
                      child: Text("발의법안", style: _profileCountDescriptionStyle, textAlign: TextAlign.center,),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const SizedBox( height: 30),
                        Text("${profile.subscriberCount}", style: _profileCountStyle, textAlign: TextAlign.center),
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                      child: Text("구독", style: _profileCountDescriptionStyle, textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 160,
              child: Text(
                profile.description,
                textAlign: TextAlign.start,
                style: _profileDescriptionStyle,
              ),
            )
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommitteeSubscriptionButtonWidget(
                  width: 120,
                  subscription: subscription,
                  then: () async {
                    await ref.read(toggleCommitteeSubscriptionViewModelProvider).execute(subscription);
                    ref.invalidate(committeeProfileFutureProvider);
                  },
                ),
                const SizedBox(width: 16),
                CommitteeNotificationButtonWidget(
                  width: 120,
                  notification: notification,
                  then: () async {
                    await ref.read(toggleCommitteeNotificationViewModelProvider).execute(notification);
                    ref.invalidate(committeeProfileFutureProvider);
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: ColorPalette.greyLight,  // 선 색상
            thickness: 1,         // 선 두께
            indent: 10,           // 왼쪽 여백
            endIndent: 10,        // 오른쪽 여백
          )
        ],
      ),
    );
  }

  Widget _buildLoading(WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Shimmer.fromColors(
                    baseColor: ColorPalette.greyLight,
                    highlightColor: ColorPalette.whitePrimary,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ColorPalette.greyLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
              ),
             Container(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(height: 30),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                      child: Text("발의법안", style: _profileCountDescriptionStyle, textAlign: TextAlign.center,),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox( height: 30),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                      child: Text("구독", style: _profileCountDescriptionStyle, textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const SizedBox(height: 160)
          ),
          const SizedBox(height: 60),
          const Divider(
            color: ColorPalette.greyLight,  // 선 색상
            thickness: 1,         // 선 두께
            indent: 10,           // 왼쪽 여백
            endIndent: 10,        // 오른쪽 여백
          )
        ],
      ),
    );
  }
}
