import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/features/committee/view/committee_account_list_widget.dart';
import 'package:front/features/committee/viewmodel/committee_account_provider.dart';
import 'package:provider/provider.dart';

import '../data/committee_account.dart';

class CommitteeView extends StatelessWidget {

  const CommitteeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CommitteeAccountProvider>();
    viewModel.retrieve();
    List<CommitteeAccount> committees = viewModel.data?.accounts ?? [];
    return Scaffold(
        body: CommitteeAccountListWidget(accounts: committees)
    );
  }
}