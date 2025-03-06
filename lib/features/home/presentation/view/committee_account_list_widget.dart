import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/core/utils/icon_utils.dart';

import '../../domain/entities/committee_account.dart';

class CommitteeAccountListWidget extends StatelessWidget {

  final List<SubscribeCommitteeInfo> accounts;

  const CommitteeAccountListWidget({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // ✅ 부모의 스크롤에 맞춰 크기 조절
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: accounts.length,
      addAutomaticKeepAlives: false, // 🔥 불필요한 상태 유지 비활성화
      addRepaintBoundaries: false, // 🔥 불필요한 리빌드 방지
      cacheExtent: 1000, // 🔥 미리 로드하여 끊김 방지
      itemBuilder: (context, index) {
        final SubscribeCommitteeInfo account = accounts[index];
        final SvgPicture icon = CommitteeIconContainer.findByName(account.name);
        return createCardWith(icon, account);
      },
    );
  }
}

Card createCardWith(SvgPicture icon, SubscribeCommitteeInfo account) {
  return  Card(
    margin: EdgeInsets.zero,
    color: ColorPalette.innerContent,
    elevation: 0,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    child: ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: 0), // 간격 조정
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      leading: Container(
        alignment: Alignment.centerLeft,
        width: 32,
        height: 32,
        margin: const EdgeInsets.only(left: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: ColorPalette.background,
            borderRadius: BorderRadius.circular(12)
        ),
        child: icon,
      ),
      title: Text(
          account.name,
          style: TextStylePreset.listElement
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12),
      onTap: () {
        // 리스트 아이템 클릭 이벤트
        print("Clicked: ${account.name}");
      },
    ),
  );
}