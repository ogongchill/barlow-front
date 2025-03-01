import 'package:flutter/material.dart';
import 'package:front/features/committee/view/committe_list_view.dart';

import '../../../core/theme/color_palette.dart';

class CommitteeHomeView extends StatelessWidget{

  const CommitteeHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorPalette.greyLight,
        appBar: AppBar(title: const Text("App Bar in Progress,,,,")),
        body: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child : const CommitteeListView()
          ),
        ),
      );
  }
}