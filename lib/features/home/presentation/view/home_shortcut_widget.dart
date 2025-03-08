import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';

class HomeShortcutWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _createColumn();
  }

  Column _createColumn() {
    return Column(
      children: [
        _createCard("상임위원회 더 알아보기", () => print("clicked 상임위원회 더 알아보기")),
        _createCard("최근 접수된 법안 보러가기", () => print("clicked 최근 접수된 법안 보러가기")),
      ],
    );
  }

  Card _createCard(String description, Function onTapFunction) {
    return Card(
      clipBehavior: Clip.hardEdge,
      // 내부 위젯이 테두리 모양을 따르도록 설정
      margin: const EdgeInsets.only(top: 10),
      color: ColorPalette.innerContent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        leading: Container(
          alignment: Alignment.centerLeft,
          width: 20,
          height: 32,
        ),
        title: Text(
          description,
          style: TextStylePreset.tab,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          onTapFunction();
        },
      ),
    );
  }
}