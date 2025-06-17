import 'package:design_system/icon_utils.dart';
import 'package:design_system/theme/color_palette.dart';
import 'package:design_system/theme/test_style_preset.dart';
import 'package:features/home/domain/entities/committee_account.dart';
import 'package:features/navigation/application_navigation_service.dart';
import 'package:features/bill/domain/constant/committee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscribeCommitteeListView extends ConsumerWidget {

  final List<SubscribeCommitteeInfo> accounts;

  const SubscribeCommitteeListView({super.key, required this.accounts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        return createCardWith(icon, account, ref);
      },
    );
  }
}

Card createCardWith(SvgPicture icon, SubscribeCommitteeInfo account, WidgetRef ref) {
  return  Card(
    margin: EdgeInsets.zero,
    color: ColorPalette.innerContent,
    elevation: 0,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    child: ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: 0), // 간격 조정
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
      onTap: () => ApplicationNavigatorService.pushToCommitteeProfile(ref, Committee.findByName(account.name))
    ),
  );
}