import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'committee_icons.dart';
import '../data/committee_account.dart';

class CommitteeAccountListWidget extends StatelessWidget {

  final List<CommitteeAccount> accounts;

  const CommitteeAccountListWidget({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: accounts.length,
      addAutomaticKeepAlives: false, // 🔥 불필요한 상태 유지 비활성화
      addRepaintBoundaries: false, // 🔥 불필요한 리빌드 방지
      cacheExtent: 1000, // 🔥 미리 로드하여 끊김 방지
      itemBuilder: (context, index) {
        final CommitteeAccount account = accounts[index];
        final SvgPicture icon = CommitteeIconContainer.findByName(account.name);
        return createCardWith(icon, account);
      },
    );
  }
}

Card createCardWith(SvgPicture icon, CommitteeAccount account) {
  return  Card(
    margin: EdgeInsets.zero,
    color: const Color(0xfff2f2f2),
    elevation: 0,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      leading: Container(
        alignment: Alignment.centerLeft,
        width: 32,
        height: 32,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: const Color(0xFFE6E6E6),
            borderRadius: BorderRadius.circular(12)
        ),
        child: icon,
      ),
      title: Text(account.name,
          style: const TextStyle(
              fontFamily: 'GmarketSans',
              fontSize: 16,
              fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {
        // 리스트 아이템 클릭 이벤트
        print("Clicked: ${account.name}");
      },
    ),
  );
}