import 'package:design_system/theme/test_style_preset.dart';
import 'package:flutter/widgets.dart';
// import 'package:front/core/theme/test_style_preset.dart';

class BillDetailParagraphWidget extends StatelessWidget {

  final String text;

  const BillDetailParagraphWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<String> paragraphs = text
        .split('\n') // ✅ 개행 문자 기준으로 분할
        .where((paragraph) => paragraph.trim().isNotEmpty) // ✅ 빈 문장 제거
        .toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((paragraph) {
        return Padding(
          padding: EdgeInsets.only(bottom: isHead(paragraph) ? 50 : 40.0), // 🔥 빈 줄(문단 구분)일 때 더 큰 간격
          child: paragraph.isNotEmpty
              ? Text(
            paragraph,
            style: isHead(paragraph)
                ? TextStylePreset.billDetailHead
                : TextStylePreset.billDetailText
          )
              : SizedBox.shrink(), // 빈 줄이면 간격만 추가하고 텍스트 출력 안 함
        );
      }).toList(),
    );
  }

  bool isHead(String text) {
    return {
      "제안이유",
      "제안 이유",
      "제안 이유 및 주요내용",
      "제안이유 및 주요내용",
      "제안이유 및 주요 내용",
      "주요내용",
      "주요 내용",
    }.any((keyword) => text.replaceAll("\n", "").trim() == keyword);// ✅ 문자열 앞뒤 공백 제거 후 비교
  }
}