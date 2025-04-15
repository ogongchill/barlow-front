import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/committee/presentation/viewmodel/committee_subscription_viewmodel.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:go_router/go_router.dart';

import 'package:front/features/home/presentation/viewmodel/home_view_provider.dart';

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
      ref.invalidate(subscribeCommitteeAccountFutureProvider);
    }
  }

  static void goToCommitteeSubscription() => GoRouter.of(_context!).go('/committee');

  static Future<void> pushToCommitteeProfile(WidgetRef ref, Committee committee) async {
    final context = _context;
    if (context == null) return;

    final result = await GoRouter.of(context).push<bool>('/committee/profile/${committee.name}');

    if (result is bool && result) {
      ref.invalidate(committeeSubscriptionFutureProvider);
    }
  }

  static void pushToRecentBill() => GoRouter.of(_context!).push('/bill/recent');

  static void pushToPreAnnounce() => GoRouter.of(_context!).push('/pre-announce');

  static void pushToPreAnnounceDetail(billId) => GoRouter.of(_context!).push('/pre-announce/detail/$billId');

  static void goToHome() => GoRouter.of(_context!).go('/');

  static void goToSettings() => GoRouter.of(_context!).go('/settings');

  static void pushToNotificationCenter() => GoRouter.of(_context!).push('/notifications');

  static void popWithResult(BuildContext context) {
    return Navigator.pop(context, true);
  }
}