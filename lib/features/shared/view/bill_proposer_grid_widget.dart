import 'package:flutter/material.dart';
import 'package:front/features/shared/domain/bil_detail.dart';

class BillProposerGridWidget extends StatelessWidget {
  final List<BillProposer> billProposers;

  const BillProposerGridWidget({super.key, required this.billProposers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // ✅ 부모 위젯 크기에 맞게 조정 (스크롤 가능)
      physics: const NeverScrollableScrollPhysics(), // ✅ 부모 위젯에서 스크롤 제어할 경우 사용
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // ✅ 2열 그리드 (3으로 변경 가능)
        crossAxisSpacing: 10, // ✅ 열 간격
        mainAxisSpacing: 10, // ✅ 행 간격
        childAspectRatio: 1, // ✅ 항목 비율 조정 (너비 대비 높이)
      ),
      itemCount: billProposers.length,
      itemBuilder: (context, index) {
        return _buildProposerCard(billProposers[index]);
      },
    );
  }

  Widget _buildProposerCard(BillProposer proposer) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(proposer.profileImage), // ✅ 프로필 이미지
          ),
          const SizedBox(height: 8),
          Text(proposer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(proposer.party.name, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
