import 'package:flutter/widgets.dart';
import 'package:front/core/theme/test_style_preset.dart';

class BillDetailParagraphWidget extends StatelessWidget {

  final String text;

  const BillDetailParagraphWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<String> paragraphs = text.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((paragraph) {
        return Padding(
          padding: EdgeInsets.only(bottom: paragraph.isEmpty ? 50.0 : 50.0), // 🔥 빈 줄(문단 구분)일 때 더 큰 간격
          child: paragraph.isNotEmpty
              ? Text(
            paragraph,
            style: TextStylePreset.billDetailText
          )
              : SizedBox.shrink(), // 빈 줄이면 간격만 추가하고 텍스트 출력 안 함
        );
      }).toList(),
    );
  }
}