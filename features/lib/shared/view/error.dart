import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/test_style_preset.dart';
import 'package:flutter/cupertino.dart';

class SomethingWentWrongWidget extends StatelessWidget {

  const SomethingWentWrongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: ColorPalette.background,
            child: Container(
              margin: EdgeInsets.all(80),
              child: Image.asset("assets/pictures/error_picture.png"),
            ),
          ),
          Text(
            " 현재 페이지를 불러오는 중 예상치 못한 문제가 발생했습니다. \n\n 페이지를 새로고침하거나, 잠시 후 다시 방문해 주세요.",
            style: TextStylePreset.sectionTitle,)
        ],
      ),
    );
  }
}