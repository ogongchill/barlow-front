import 'package:flutter/material.dart';
import 'package:front/dev/dummy-repository/dummy_today_bill_thumbnail_repository.dart';
import 'package:front/features/home/domain/repositories/committee_account_repository.dart';
import 'package:front/dev/dummy-repository//dummy_committee_retrieve_provider.dart';
import 'package:front/features/home/domain/repositories/today_bill_thumbnail_repository.dart';
import 'package:front/features/home/domain/usecases/get_today_bill_thumbnails_usecase.dart';
import 'package:front/features/home/presentation/viewmodel/get_today_bill_thumbnails_provider.dart';

import 'features/home/domain/usecases/get_subscribe_committee_usecase.dart';
import 'features/home/presentation/view/committee_home_view.dart';
import 'features/home/presentation/viewmodel/committee_account_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

final GetIt getIt = GetIt.instance;

void main() {
  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CommitteeAccountProvider>(
          create: (context) => getIt<CommitteeAccountProvider>()),
      ChangeNotifierProvider<GetTodayBillThumbnailsProvider>(
          create: (context) => getIt<GetTodayBillThumbnailsProvider>()),
    ],
    child: MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light, // 밝은 모드 강제 적용
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: true,
      home: CommitteeHomeView(),
    ),
  ));
}

void setupLocator() {
  // dependency injection for fetching subscribed committee account
  getIt.registerLazySingleton<SubscribeCommitteeInfoRepository>(
      () => DummyCommitteeAccountRepositoryFactory.withFromTopFive());
  getIt.registerLazySingleton<GetSubscribeCommitteeUseCase>(
      () => GetSubscribeCommitteeUseCase(getIt<SubscribeCommitteeInfoRepository>()));
  getIt.registerLazySingleton<CommitteeAccountProvider>(
      () => CommitteeAccountProvider(useCase: getIt<GetSubscribeCommitteeUseCase>()));
  // dependency injection for fetching today's bill thumbnails
  getIt.registerLazySingleton<TodayBillThumbnailRepository>(
      () => DummyTodayBillThumbnailRepositoryFactory.withAllSamples());
  getIt.registerLazySingleton<GetTodayBillThumbnailsUseCase>(
      () => GetTodayBillThumbnailsUseCase(getIt<TodayBillThumbnailRepository>()));
  getIt.registerLazySingleton<GetTodayBillThumbnailsProvider>(
      () => GetTodayBillThumbnailsProvider(getIt<GetTodayBillThumbnailsUseCase>()));
}
