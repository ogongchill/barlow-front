import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/features/committee/view/committee_account_list_widget.dart';
import 'package:front/features/committee/viewmodel/committee_account_provider.dart';
import 'package:provider/provider.dart';

class CommitteeView extends StatelessWidget {

  const CommitteeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CommitteeAccountProvider>();
    return FutureBuilder(
      future: viewModel.state == CommitteeAccountRetrieveState.initial
          ? viewModel.retrieve()
          : null, // 이미 로드된 상태면 API 호출 안 함
      builder: (context, snapshot) {
        if (viewModel.state == CommitteeAccountRetrieveState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.state == CommitteeAccountRetrieveState.error) {
          return Center(child: Text('Error: ${viewModel.errorMessage}'));
        } else if (viewModel.state == CommitteeAccountRetrieveState.empty) {
          return const Center(child: Text('No committees found.'));
        } else {
          return Scaffold(
            body: CommitteeAccountListWidget(
              accounts: viewModel.data?.accounts ?? [],
            ),
          );
        }
      },
    );
  }
}

void retrieveIfInitial(BuildContext context, CommitteeAccountProvider viewModel) {
  if(viewModel.state == CommitteeAccountRetrieveState.initial) {
    viewModel.retrieve();
  }
}