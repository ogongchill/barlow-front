import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/presentation/view/committee_profile_widget.dart';
import 'package:front/features/committee/presentation/viewmodel/commitee_profile_viewmodel.dart';
import 'package:front/features/shared/domain/committee.dart';

class CommitteeProfileView extends ConsumerWidget {

  final Committee _committee;

  const CommitteeProfileView(this._committee, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: ColorPalette.background,
      body: CommitteeProfileWidget(_committee),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_committee.name, style: TextStylePreset.appBarTitle),
      backgroundColor: ColorPalette.innerContent,
    );
  }
}