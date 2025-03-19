import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationNavigatorService {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void pushToBillDetail({required String billId, required String title, String? subtitle}) {
    navigatorKey.currentState?.context.push('/bill/detail/$billId', extra: {"title" : title, "subtitle" : subtitle});
  }

  static void pushToCommitteeSubscription() {
    navigatorKey.currentState?.context.push('/committee');
  }
}