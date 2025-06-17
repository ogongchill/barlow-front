import 'package:design_system/animations/animations.dart';
import 'package:design_system/icon_utils.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/text_style_preset.dart';
import 'package:features/bill/domain/entities/committe_notification.dart';
import 'package:features/bill/domain/entities/committee_profile.dart';
import 'package:features/bill/domain/entities/committee_subscription.dart';
import 'package:features/bill/presentation/viewmodel/commitee_profile_viewmodel.dart';
import 'package:features/bill/domain/constant/committee.dart';
import 'package:features/bill/presentation/viewmodel/committee_notificaction_provider.dart';
import 'package:features/bill/presentation/viewmodel/committee_subscription_viewmodel.dart';
import 'package:features/shared/presentation/widget/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';

class CommitteeProfileView extends ConsumerWidget {

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

  const CommitteeProfileView(this._committee, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final committeeProfile = ref.watch(committeeProfileFutureProvider(_committee));
    return committeeProfile.when(
      data: (profile) => _buildProfileUI(profile, ref, context),
      error: (err, stack) => const SomethingWentWrongWidget(),
      loading: () => _buildLoading(ref),
    );
  }


  Widget _buildProfileUI(CommitteeProfile profile, WidgetRef ref, BuildContext context) {
    final subscription = CommitteeSubscription(committee: profile.committee, isSubscribed: profile.isSubscribed);
    final notification = CommitteeNotification(committee: profile.committee, isActive: profile.isNotificationActive);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                child: SvgPicture.asset(
                  CommitteeIcons.findByName(profile.committee.value).path,
                  width: 60,
                  height: 60,
                ),
              ),
              Column(
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
              Column(
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
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
                profile.description,
                textAlign: TextAlign.start,
                style: _profileDescriptionStyle,
              ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CommitteeSubscriptionButtonWidget(
                  width: MediaQuery.of(context).size.width * 0.4,
                  subscription: subscription,
                  then: () async {
                    await ref.read(toggleCommitteeSubscriptionViewModelProvider).execute(subscription);
                    ref.invalidate(committeeProfileFutureProvider);
                  },
                ),
                _CommitteeNotificationButtonWidget(
                  width: MediaQuery.of(context).size.width * 0.4,
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

class _CommitteeNotificationButtonWidget extends ConsumerWidget {

  final CommitteeNotification _notification;
  final Function _afterOnPressedFunction;
  final double? _width;
  final double? _height;

  const _CommitteeNotificationButtonWidget({
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
    final isAnimationActive = ref.watch(profileNotificationToggleAnimationProvider(_notification.committee));
    final isButtonDisabled = ref.watch(profileNotificationButtonDisabledProvider(_notification.committee));

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
              ref.read(profileNotificationButtonDisabledProvider(_notification.committee).notifier).state = true; // 버튼 비활성화
              if (!_notification.isActive) {
                ref.read(profileNotificationToggleAnimationProvider(_notification.committee).notifier).state = true; // 구독 안되어있을때 "구독"버튼 눌러야만 애니메이션
              }
              _afterOnPressedFunction();
              ref.read(profileNotificationButtonDisabledProvider(_notification.committee).notifier).state = false;
            },
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.black26,
              backgroundColor: ColorPalette.greyLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
            child: _notification.isActive
                ? const Icon(Icons.notifications_off_rounded, color: ColorPalette.whitePrimary)
                : const Icon(Icons.notifications_active_rounded, color: ColorPalette.orangePrimary),
          ),
        ),
        Positioned(
          top: -20,
          left: _width == null ? -2 : (_width - 80) / 2 -2,
          child: isAnimationActive
              ? Lottie.asset(
            AnimationAssets.fireWorkPath,
            width: 100,
            height: 100,
            repeat: false, // ✅ 한 번만 실행
            onLoaded: (composition) {
              Future.delayed(composition.duration, () {
                ref.read(profileNotificationToggleAnimationProvider(_notification.committee).notifier).state = false;
              });
            },
          )
              : const SizedBox.shrink(),
        ),
      ],
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
    final isFireworkActive = ref.watch(profileFireworkAnimationProvider(_subscription.committee));
    final isButtonDisabled = ref.watch(profileSubscribeButtonDisabledProvider(_subscription.committee));

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
              ref.read(profileSubscribeButtonDisabledProvider(_subscription.committee).notifier).state = true; // 버튼 비활성화
              if (!_subscription.isSubscribed) {
                ref.read(profileFireworkAnimationProvider(_subscription.committee).notifier).state = true; // 구독 안되어있을때 "구독"버튼 눌러야만 애니메이션
              }
              _afterOnPressedFunction();
              ref.read(profileSubscribeButtonDisabledProvider(_subscription.committee).notifier).state = false;
            },
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.black26,
              backgroundColor: isButtonDisabled
                  ? ColorPalette.blueLight //  애니메이션이 진행 중이면 버튼 색을 변경
                  : (_subscription.isSubscribed ? ColorPalette.greyLight : ColorPalette.bluePrimary),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
            AnimationAssets.fireWorkPath,
            width: 100,
            height: 100,
            repeat: false, // ✅ 한 번만 실행
            onLoaded: (composition) {
              Future.delayed(composition.duration, () {
                ref.read(profileFireworkAnimationProvider(_subscription.committee).notifier).state = false;
              });
            },
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
