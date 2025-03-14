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

  static const TextStyle thumbnailTitle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.black
  );

  static const TextStyle thumbnailSubtitle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 10,
      color: ColorPalette.textContent
  );

  static const TextStyle innerContentSubtitle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: Colors.black
  );

  static const TextStyle innerContentLight = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w300,
      fontSize: 12,
      color: ColorPalette.textContent
  );

  static const TextStyle sectionTitle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: ColorPalette.textHead
  );

  static const TextStyle billDetailText = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 1.5,
      color: ColorPalette.textContent
  );

  static const TextStyle billDetailHead = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: Colors.black
  );

  static const TextStyle barInnerText = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.white
  );

  static const TextStyle appBarTitle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: ColorPalette.textHead
  );

  static const TextStyle appBarSubtitle = TextStyle(
      fontFamily: "gmarketSans",
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: ColorPalette.textHead
  );
}