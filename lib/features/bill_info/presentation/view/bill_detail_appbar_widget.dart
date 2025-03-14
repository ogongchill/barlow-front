import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';

class BillDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final String? _subtitle;

  const BillDetailAppBar({required String title, String? subtitle, super.key})
      : _title = title,
        _subtitle = subtitle;

  @override
  Widget build(BuildContext context) {
    return _createAppBar(context);
  }

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
      actions: [
        IconButton(
          icon: Icon(Icons.save), // ✅ 저장 버튼 (trailing)
          onPressed: () => print("clicked save button"), // ✅ 저장 버튼 클릭 이벤트
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
