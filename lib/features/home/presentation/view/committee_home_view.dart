import 'package:flutter/material.dart';

import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/home/presentation/view/home_shortcut_widget.dart';
import 'package:front/features/home/presentation/view/today_bill_thumbnail_widget.dart';
import 'committee_list_view.dart';

class CommitteeHomeView extends StatelessWidget{

  const CommitteeHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorPalette.background,
        appBar: AppBar(title: const Text("App Bar in Progress,,,,")),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),// 💡 ListView로 변경하여 스크롤 문제 해결
          children: [
            HomeShortcutWidget(),
            const CommitteeListView(),
            const TodayBillThumbnailWidget(),
          ],
        ),
      )
    );
  }
}