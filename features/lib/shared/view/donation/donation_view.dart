import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/test_style_preset.dart';
import 'package:features/shared/view/appbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationView extends StatelessWidget {

  static const _kakaoPayUrl = 'https://link.kakaopay.com/_/qyEmuUq';

  const DonationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: const TextAppBar(title: "후원"),
      body: Container(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("죄송합니다 아직 개발 진행중이에요", style: TextStylePreset.sectionTitle,),
            Image.asset("assets/pictures/donation.png"),
            Column(
              children: [const Text("서버비 후원하기", style: TextStylePreset.sectionTitle,),
                GestureDetector(
                    onTap: _openKakaoPay,
                    child: Image.asset(
                      'assets/pictures/kakao_send_regular.png',
                      width: 150,
                      fit: BoxFit.contain,
                    )
                )],
            )
          ],
        ),
      )
    );
  }

  void _openKakaoPay() async {
    final url = Uri.parse(_kakaoPayUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // 외부 브라우저!
      );
    } else {
      print('❌ KakaoPay 링크 열 수 없음');
    }
  }
}