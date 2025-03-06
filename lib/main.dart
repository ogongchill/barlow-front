import 'package:flutter/material.dart';
import 'package:front/features/home/domain/repositories/committee_account_repository.dart';
import 'package:front/dev/provider/dummy_committee_retrieve_provider.dart';

import 'features/home/domain/usecases/get_subscribe_committee_usecase.dart';
import 'features/home/presentation/view/committee_home_view.dart';
import 'features/home/presentation/viewmodel/committee_account_provider.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void main() {
  setupLocator();
  runApp(MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light, // 밝은 모드 강제 적용
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: true,
          home: CommitteeHomeView(),
        ),
  );
}

void setupLocator() {
  getIt.registerLazySingleton<SubscribeCommitteeInfoRepository>(() => DummyCommitteeAccountRepositoryFactory().withFromTopFive());
  getIt.registerLazySingleton<GetSubscribeCommitteeUseCase>(() => GetSubscribeCommitteeUseCase(getIt<SubscribeCommitteeInfoRepository>()));
  getIt.registerLazySingleton<CommitteeAccountProvider>(() => CommitteeAccountProvider(useCase: getIt<GetSubscribeCommitteeUseCase>()));
}