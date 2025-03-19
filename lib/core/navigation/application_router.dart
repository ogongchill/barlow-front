import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/features/bill_info/presentation/view/bill_detail_view.dart';
import 'package:front/features/committee/presentation/view/committee_subscription_view.dart';
import 'package:front/features/home/presentation/view/committee_home_view.dart';
import 'package:go_router/go_router.dart';

final applicationRouterProvider = Provider<GoRouter> ((ref) {
  return applicationRouter;
});

final GoRouter applicationRouter = GoRouter(
  navigatorKey: ApplicationNavigatorService.navigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    _homeRouter,
    _billRouter,
    _committeeRouter
  ],
);

final GoRoute _homeRouter = GoRoute(
  path: '/',
  builder: (context, state) {
    return const CommitteeHomeView();
  }
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
          })
    ]
);

final GoRoute _committeeRouter = GoRoute(
      path: '/committee',
      builder: (context, state) => const CommitteeSubscriptionView()
);