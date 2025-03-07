import 'package:flutter/material.dart';
import 'package:front/core/api/fetch_status.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/home/presentation/viewmodel/committee_account_provider.dart';

import 'committee_account_list_widget.dart';
import 'package:provider/provider.dart';

class CommitteeListView extends StatelessWidget {
  const CommitteeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final CommitteeAccountProvider provider = Provider.of<CommitteeAccountProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.retrieve(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 제목 왼쪽 정렬
          children: [
            _createTitleBox(), // 제목 박스 추가
            _createInnerContainer(provider),
            _createBottomCommitteeButton()// 기존 리스트 컨테이너
          ],
        );
      },
    );
  }

  Widget _createTitleBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
        color: ColorPalette.innerContent, // 배경색 추가
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: const Text(
        "내 구독 목록",
        style: TextStylePreset.innerContentSubtitle, // 기존 스타일 적용
      ),
    );
  }

  Widget _createBottomCommitteeButton() {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.zero, topRight: Radius.zero,
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)
        )
      ),
      margin: const EdgeInsets.only(bottom: 30),
      color: ColorPalette.innerContent, // 배경색 추가
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        title: const Text(
          "상임위원회 더 알아보기",
          style: TextStylePreset.innerContentSubtitle, // 기존 스타일 적용
        ),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
        onTap: () => print("clicked 상임위원회 더 알아보기"),
      )
    );
  }

  SingleChildScrollView _createInnerContainer(
      CommitteeAccountProvider provider) {
    if (provider.state == FetchStatus.error) {
      return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: ColorPalette.innerContent,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child:
                const Text("상임위원회 조회에 실패했습니다", style: TextStylePreset.listElement),
      ));
    }
    if (provider.state == FetchStatus.empty) {
      return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: ColorPalette.innerContent,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text("관심있는 상임위원회가 없습니다", style: TextStylePreset.innerContentLight),
      ));
    }
    return SingleChildScrollView(
        child: CommitteeAccountListWidget(accounts: provider.accounts));
  }
}
