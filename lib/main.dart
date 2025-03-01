import 'package:flutter/material.dart';
import 'package:front/features/committee/data/committee_retrieve_api_repository.dart';
import 'package:front/features/committee/view/committee_home_view.dart';
import 'package:front/features/committee/viewmodel/committee_account_provider.dart';
import 'package:provider/provider.dart';
import 'package:front/dev/provider/dummy_committee_retrieve_provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          Provider<CommitteeRetrieveApiRepository>(create: (_) =>
              DummyCommitteeRetrieveProviderFactory().withAllCommittee()),
          Provider<CommitteeAccountProvider>(create: (context) =>
              CommitteeAccountProvider(repository: context.read<CommitteeRetrieveApiRepository>()))
        ],
        child:
        MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light, // 밝은 모드 강제 적용
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: true,
          home: CommitteeHomeView(),
        ),
     )
  );
}
