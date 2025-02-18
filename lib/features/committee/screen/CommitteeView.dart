import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommitteeView extends StatelessWidget {

  const CommitteeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.help_outline, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuItem(Icons.account_circle, '우리동네 국회의원 보러가기'),
            const SizedBox(height: 10),
            _buildMenuItem(Icons.account_circle, '최근 접수된 법안 보러가기'),
            const SizedBox(height: 20),
            _buildCommitteeSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // 클릭 시 동작
        },
      ),
    );
  }


  Widget _buildCommitteeSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.gavel, color: Colors.black),
            title: const Text('법제사법 위원회'),
            onTap: () {},
          ),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('기획재정 위원회'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.black),
            title: const Text('정무 위원회'),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.black),
            title: const Text('국회운영 위원회'),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.black),
            title: const Text('과학기술정보방송통신 위원회'),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('소관위원회 더 알아보러 가기'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}