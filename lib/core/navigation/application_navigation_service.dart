import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationNavigatorService {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void pushToBillDetail(String billId) {
    navigatorKey.currentState?.context.push('/bill/detail/$billId');
  }
}