import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_router.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/bill_info/presentation/view/bill_detail_view.dart';

import 'features/home/presentation/view/committee_home_view.dart';

void main() {
  setupLocator();
  runApp(
    const ProviderScope(
      child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      routerConfig: applicationRouter, // ✅ GoRouter 적용
    );
  }
}

class DevApp extends StatelessWidget {

  const DevApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BillDetailView(title: "" , billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5"),
    );
  }
}