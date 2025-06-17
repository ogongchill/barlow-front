import 'package:features/bill/presentation/screen/bill_detail_screen.dart';
import 'package:features/bill/presentation/screen/preannounce_bill_detail_screen.dart';
import 'package:features/bill/presentation/screen/preannounce_thumbnail_screen.dart';
import 'package:features/bill/presentation/screen/recent_bill_thumbnail_screen.dart';
import 'package:features/bill/presentation/screen/committee_profile_screen.dart';
import 'package:features/bill/presentation/screen/committee_list_screen.dart';
import 'package:features/home/presentation/screen/home_screen.dart';
import 'package:features/home/presentation/screen/notification_center_screen.dart';
import 'package:features/settings/presentation/screen/notification_setting_screen.dart';
import 'package:features/settings/presentation/screen/setting_screen.dart';
import 'package:features/bill/domain/constant/committee.dart';
import 'package:features/splash/presentation/screen/on_boarding_screen.dart';
import 'package:features/splash/presentation/view/permisssion_view.dart';
import 'package:features/splash/presentation/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:features/navigation/application_navigation_service.dart';

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
    _splashRouter,
    _onBoardingRouter
  ],
);

final GoRoute _homeRouter = GoRoute(
  path: '/',
  builder: (context, state) {
    return const HomeScreen();
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
            return BillDetailScreen(title: title, subtitle: subtitle, billId: billId);
          }),
      GoRoute(
          path: '/recent',
          builder: (context, state) => RecentBillThumbnailScreen()
      )
    ]
);

final GoRoute _committeeRouter = GoRoute(
      path: '/committee',
      builder: (context, state) => const CommitteeListScreen(),
      routes: [
        GoRoute(
            path: '/profile/:committeeName',
            builder : (context, state) {
              final Committee target = Committee.findByName(state.pathParameters['committeeName']!);
              return CommitteeProfileScreen(target);
            }
        )
      ]
);

final GoRoute _preAnnounceRouter = GoRoute(
  path: '/pre-announce',
  builder: (context, state) => const PreAnnounceThumbnailScreen(),
  routes: [
    GoRoute(
      path: '/detail/:billId',
      builder: (context, state) => PreAnnounceBillDetailScreen(billId: state.pathParameters['billId']!)
    )
  ]
);

final GoRoute _settingRouter = GoRoute(
  path: '/settings',
  builder: (context, state) => const SettingScreen(),
  routes: [
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationSettingScreen()
    )
  ]
);

final GoRoute _notificationRouter = GoRoute(
    path: '/notifications',
    builder: (context, state) => const NotificationCenterScreen()
);

final GoRoute _splashRouter = GoRoute(
    path: '/splash',
    builder: (context, state) => const SplashScreen(),
    routes: [
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionView()
      )
    ]
);

final GoRoute _onBoardingRouter = GoRoute(
  path: '/onboarding',
  builder: (context, state) => const OnboardingScreen()
);