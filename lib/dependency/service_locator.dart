import 'package:front/dev/dummy-repository/dummy_committee_retrieve_provider.dart';
import 'package:front/dev/dummy-repository/dummy_today_bill_thumbnail_repository.dart';
import 'package:front/features/home/domain/repositories/committee_account_repository.dart';
import 'package:front/features/home/domain/repositories/today_bill_thumbnail_repository.dart';
import 'package:front/features/home/domain/usecases/get_subscribe_committee_usecase.dart';
import 'package:front/features/home/domain/usecases/get_today_bill_thumbnails_usecase.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // for fetching today bill thumbnails
  getIt.registerLazySingleton<TodayBillThumbnailRepository>(
          () => DummyTodayBillThumbnailRepositoryFactory.withAllSamples());
  getIt.registerLazySingleton<GetTodayBillThumbnailsUseCase>(
          () => GetTodayBillThumbnailsUseCase(getIt<TodayBillThumbnailRepository>()));

  // for fetching subscribed committee info
  getIt.registerLazySingleton<SubscribeCommitteeInfoRepository>(
          () => DummyCommitteeAccountRepositoryFactory.withRandom());
  getIt.registerLazySingleton<GetSubscribeCommitteeUseCase>(
          () => GetSubscribeCommitteeUseCase(getIt<SubscribeCommitteeInfoRepository>()));

}
