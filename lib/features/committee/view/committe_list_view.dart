import 'package:flutter/material.dart';
import 'package:front/core/theme/color_palette.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/features/committee/view/committee_account_list_widget.dart';
import 'package:front/features/committee/viewmodel/committee_account_provider.dart';
import 'package:provider/provider.dart';

class CommitteeListView extends StatelessWidget {

  const CommitteeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommitteeAccountProvider>(context);
    return FutureBuilder(
      future: provider.retrieve(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return _createInnerContainer(provider);
      },
    );
  }

  SingleChildScrollView _createInnerContainer(
      CommitteeAccountProvider provider) {
    if (provider.state == CommitteeAccountRetrieveState.error) {
      return SingleChildScrollView(
          child: _createColumn(
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: ColorPalette.whitePrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                    "상임위원회 조회에 실패했습니다", style: TextStylePreset.listElement),
              )
          )
      );
    }
    if (provider.state == CommitteeAccountRetrieveState.empty) {
      return SingleChildScrollView(
          child: _createColumn(
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: ColorPalette.whitePrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                    "관심있는 상임위원회가 없습니다", style: TextStylePreset.listElement),
              )
          )
      );
    }
    return SingleChildScrollView(
        child: _createColumn(
            CommitteeAccountListWidget(accounts: provider.data?.accounts ?? []))
    );
  }

  Column _createColumn(StatelessWidget content) {
    return Column(
      children: [
        _createCard("상임위원회 더 알아보기", () => print("clicked 상임위원회 더 알아보기")),
        _createCard("최근 접수된 법안 보러가기", () => print("clicked 최근 접수된 법안 보러가기")),
        Container(
          decoration: BoxDecoration(
              color: ColorPalette.whitePrimary,
              borderRadius: BorderRadius.circular(10)
          ),
          margin: const EdgeInsets.only(top: 10),
          clipBehavior: Clip.hardEdge, // ✅ 내부 위젯이 테두리 모양을 따르도록 설정
          child: content,
        )
      ],
    );
  }

  Card _createCard(String description, Function onTapFunction) {
    return Card(
      clipBehavior: Clip.hardEdge, // 내부 위젯이 테두리 모양을 따르도록 설정
      margin: const EdgeInsets.only(top: 10),
      color: ColorPalette.whitePrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        leading: Container(
          alignment: Alignment.centerLeft,
          width: 20,
          height: 32,
        ),
        title: Text(
            description,
            style: TextStylePreset.tab,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          onTapFunction();
        },
      ),
    );
  }
}