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
      padding: EdgeInsets.all(16.0),
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final CommitteeAccount account = accounts[index];
        final SvgPicture icon = CommitteeIconContainer.findByName(account.name);
        return Card(
          elevation: 4,
          margin: EdgeInsets.only(bottom: 12.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Container(
              alignment: Alignment.centerLeft,
              width: 40,
              child: icon,
            ),
            title: Text(account.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              // 리스트 아이템 클릭 이벤트
              print("Clicked: ${account.name}");
            },
          ),
        );
      },
    );
  }
}
