import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/features/bill_info/presentation/view/bill_detail_view.dart';
import 'package:front/features/bill_info/presentation/view/recent_bill_thumbnail_view.dart';
import 'package:front/features/committee/presentation/view/committee_profile_view.dart';
import 'package:front/features/committee/presentation/view/committee_subscription_view.dart';
import 'package:front/features/home/presentation/view/committee_home_view.dart';
import 'package:front/features/notification/presentation/view/notification_center_view.dart';
import 'package:front/features/pre_announce/presentation/view/preannounce_bill_detail_view.dart';
import 'package:front/features/pre_announce/presentation/view/preannounce_view.dart';
import 'package:front/features/settings/presentation/view/setting_view.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/view/donation/donation_view.dart';
import 'package:front/features/splash/presentation/view/on_boarding_view.dart';
import 'package:front/features/splash/presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';

final applicationRouterProvider = Provider<GoRouter> ((ref) {
  return applicationRouter;
});

final GoRouter applicationRouter = GoRouter(
  navigatorKey: ApplicationNavigatorService.navigatorKey,
  initialLocation: '/splash',
  routes: <RouteBase>[
    _homeRouter,
    _billRouter,
    _committeeRouter,
    _preAnnounceRouter,
    _settingRouter,
    _notificationRouter,
    _donationRouter,
    _splashRouter,
    _onBoardingRouter
  ],
);

final GoRoute _homeRouter = GoRoute(
  path: '/',
  builder: (context, state) {
    return const CommitteeHomeView();
  },
);

final GoRoute _billRouter = GoRoute(
    path: '/bill',
    builder: (context, state) => Text("notFound"), // ✅ `/bill`에 대한 builder 추가
    routes:[
      GoRoute(
          path: '/detail/:billId',
          builder: (context, state) {
            final Map<String, dynamic>? extraData = state.extra as Map<String, dynamic>?; // ✅ extra를 Map으로 변환
            final String title = extraData?["title"] ?? "법안 상세 정보";
            String? subtitle = extraData?["subtitile"];
            final String billId = state.pathParameters['billId']!; // ✅ id 추출
            return BillDetailView(title: title, subtitle: subtitle, billId: billId);
          }),
      GoRoute(
          path: '/recent',
          builder: (context, state) => RecentBillThumbnailView()
      )
    ]
);

final GoRoute _committeeRouter = GoRoute(
      path: '/committee',
      builder: (context, state) => const CommitteeSubscriptionView(),
      routes: [
        GoRoute(
            path: '/profile/:committeeName',
            builder : (context, state) {
              final Committee target = Committee.findByName(state.pathParameters['committeeName']!);
              return CommitteeProfileView(target);
            }
        )
      ]
);

final GoRoute _preAnnounceRouter = GoRoute(
  path: '/pre-announce',
  builder: (context, state) => const PreAnnounceView(),
  routes: [
    GoRoute(
      path: '/detail/:billId',
      builder: (context, state) => PreAnnounceBillDetailView(billId: state.pathParameters['billId']!)
    )
  ]
);

final GoRoute _settingRouter = GoRoute(
  path: '/settings',
  builder: (context, state) => const SettingView()
);

final GoRoute _notificationRouter = GoRoute(
    path: '/notifications',
    builder: (context, state) => const NotificationCenterView()
);

final GoRoute _donationRouter = GoRoute(
    path: '/donation',
    builder: (context, state) => const DonationView()
);

final GoRoute _splashRouter = GoRoute(
    path: '/splash',
    builder: (context, state) => SplashView()
);

final GoRoute _onBoardingRouter = GoRoute(
  path: '/onboarding',
  builder: (context, state) => const OnboardingView()
);