import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';

class CommitteeSubscriptionAppbarWidget extends StatelessWidget implements PreferredSizeWidget{

  final String _title;

  const CommitteeSubscriptionAppbarWidget({super.key, required String title})
    : _title = title;

  @override
  Widget build(BuildContext context) {
    return _createAppBar(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  AppBar _createAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.background,
      surfaceTintColor: ColorPalette.blueVeryLight,
      centerTitle: true, // ✅ 중앙 정렬
      leading: Navigator.of(context).canPop() // ✅ 뒤로 가기 버튼 (필요할 때만 표시)
          ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )
          : SizedBox(),
      title: Text(
        _title,
        style: TextStylePreset.appBarTitle,
      ),
    );
  }
}
