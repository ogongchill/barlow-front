import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:go_router/go_router.dart';

class TextAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  final String? _subtitle;
  final Function? _onPressedBack;
  final Color _backgroundColor;
  final Color _tintColor;

  const TextAppBar({
    super.key,
    required String title,
    String? subtitle,
    Function? onPressedBack,
    Color? backgroundColor,
    Color? tintColor,
  }) : _title = title,
        _subtitle = subtitle,
        _onPressedBack = onPressedBack,
        _backgroundColor = backgroundColor ?? ColorPalette.background,
        _tintColor = tintColor ?? ColorPalette.greyLight;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return _buildAppBar(context);
  }

  AppBar _buildAppBar(BuildContext context) {
    Function goBackFunction = _onPressedBack ?? () => Navigator.pop(context);
    return AppBar(
      centerTitle: true,
      leading: context.canPop()
          ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
            onPressed: () => goBackFunction(),)
          : null,
      title: _titleSection(),
      backgroundColor: _backgroundColor,
      surfaceTintColor: _tintColor,
    );
  }


  Widget _titleSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_title, style: TextStylePreset.appBarTitle),
        if(_subtitle != null)
         Text(_subtitle, style: TextStylePreset.appBarSubtitle),
      ],
    );
  }
}
