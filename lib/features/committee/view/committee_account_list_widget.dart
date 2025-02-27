import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        return Card(
          elevation: 4,
          margin: EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(account.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            title: Text(account.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text("상품 설명이 여기에 들어갑니다.", style: TextStyle(color: Colors.grey[600])),
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