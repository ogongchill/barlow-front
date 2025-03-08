import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/home/presentation/view/home_shortcut_widget.dart';
import 'package:front/features/home/presentation/view/subscirbe_committee_widget.dart';
import 'package:front/features/home/presentation/view/today_bill_thumbnail_widget.dart';
import 'package:front/features/home/presentation/viewmodel/home_view_provider.dart';

class CommitteeHomeView extends ConsumerWidget { // ✅ ConsumerWidget으로 변경
  const CommitteeHomeView({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    ref.read(homeRefreshTriggerProvider.notifier).state = !ref.read(homeRefreshTriggerProvider); // ✅ 트리거 변경
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorPalette.background,
        appBar: AppBar(title: const Text("App Bar in Progress,,,,")),
        body: RefreshIndicator( // 새로고침
          color: ColorPalette.bluePrimary,
          backgroundColor: ColorPalette.whitePrimary,
          onRefresh: () => _refresh(ref),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            children: [
              HomeShortcutWidget(),
              const SubscribeCommitteeWidget(),
              const TodayBillThumbnailWidget(),
            ],
          ),
        ),
      ),
    );
  }
}