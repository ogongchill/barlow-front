import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/navigation/application_navigation_service.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/features/committee/presentation/view/committee_profile_widget.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/view/appbar.dart';

class CommitteeProfileView extends ConsumerWidget {

  final Committee _committee;

  const CommitteeProfileView(this._committee, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: TextAppBar(
          title: _committee.name,
          onPressedBack: () => ApplicationNavigatorService.popWithResult(context),
      ),
      backgroundColor: ColorPalette.background,
      body: CommitteeProfileWidget(_committee),
    );
  }
}