import 'package:flutter/material.dart';

import 'package:front/core/theme/color_palette.dart';
import 'committee_list_view.dart';

class CommitteeHomeView extends StatelessWidget{

  const CommitteeHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorPalette.background,
        appBar: AppBar(title: const Text("App Bar in Progress,,,,")),
        body: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child : const CommitteeListView()
          ),
        ),
      );
  }
}