import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';

class TextStylePreset {

  static const TextStyle listElement = TextStyle(
    fontFamily: "gmarketSans",
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: ColorPalette.greyDark
  );

  static const TextStyle tab = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.black
  );
}