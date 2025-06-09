import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';

class DisclaimerWidget extends StatelessWidget {

  const DisclaimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      color: ColorPalette.background,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: ColorPalette.greyLight,),
          SizedBox(height: 20),
          Text("바로 앱 서비스", style: TextStylePreset.thumbnailSubtitle,),
          SizedBox(height: 20),
          Text("ogogchill@googlegroups.com", style: TextStylePreset.thumbnailSubtitle,),
          SizedBox(height: 20),
          Text("""
정보는 국회공공데이터포털(open.aseembly.go.kr)에서 제공된 데이터를 기반으로 하며, \n본 앱은 정부와 관련없는 민간 서비스입니다\n
특정 정당, 정치인, 단체의 입장을 대변하거나 지지·반대하지 않습니다. \n\n사용자 제출 내용에 대한 저장, 검토, 전달 등의 행위를 하지 않으며, 관련 절차에 개입하지 않습니다.
          """, style: TextStylePreset.thumbnailSubtitle,)
        ],
      ),
    );
  }
}