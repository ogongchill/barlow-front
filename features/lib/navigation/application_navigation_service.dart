import 'package:features/bill/presentation/viewmodel/committee_subscription_viewmodel.dart';
import 'package:features/home/presentation/viewmodel/home_view_provider.dart';
import 'package:features/bill/domain/constant/committee.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/entities/signup_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ApplicationNavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get _context => navigatorKey.currentState?.overlay?.context;

  static void pushToBillDetail({required String billId, required String title, String? subtitle}) {
    final context = _context;
    if (context == null) return;
    context.push('/bill/detail/$billId', extra: {"title": title, "subtitle": subtitle});
  }

  static Future<void> pushToCommitteeSubscription(WidgetRef ref) async {
    final context = _context;
    if (context == null) return;

    final result = await GoRouter.of(context).push<bool>('/committee');

    if (result is bool && result) {
      ref.invalidate(getHomeInfoFutureProvider);
    }
  }

  static void goToCommitteeSubscription() => GoRouter.of(_context!).go('/committee');

  static Future<void> pushToCommitteeProfile(WidgetRef ref, Committee committee) async {
    final context = _context;
    if (context == null) return;

    final result = await GoRouter.of(context).push<bool>('/committee/profile/${committee.value}');

    if (result is bool && result) {
      ref.invalidate(committeeSubscriptionFutureProvider);
    }
  }

  static void pushToRecentBill() => GoRouter.of(_context!).push('/bill/recent');

  static void pushToPreAnnounce() => GoRouter.of(_context!).push('/pre-announce');

  static void pushToPreAnnounceDetail(billId) => GoRouter.of(_context!).push('/pre-announce/detail/$billId');

  static void goToHome() => GoRouter.of(_context!).go('/');

  static void goToSettings() => GoRouter.of(_context!).go('/settings');

  static void pushToNotificationSettings() => GoRouter.of(_context!).push('/settings/notifications');

  static void pushToNotificationCenter() => GoRouter.of(_context!).push('/notifications');

  static void pushToSignupTerms({
    required SignupOption option,
    required List<TermAgreementItem> terms,
    required String nickname,
  }) {
    final context = _context;
    if (context == null) return;
    context.push('/signup/kakao/terms', extra: {
      'option': option,
      'terms': terms,
      'nickname': nickname,
    });
  }

  /// 인증 진입점으로 이동한다.
  ///
  /// 에러 발생 시 온보딩 화면으로 돌아간다.

  static void goToSplash() => GoRouter.of(_context!).go('/splash');

  static void goToOnBoarding() => GoRouter.of(_context!).go('/onboarding');

  static void goToPermissions() => GoRouter.of(_context!).go('/splash/permissions');

  /// 로그인 화면으로 이동한다.
  static void pushToLogin() => GoRouter.of(_context!).push('/login');

  static void popWithResult(BuildContext context) {
    return Navigator.pop(context, true);
  }
}
