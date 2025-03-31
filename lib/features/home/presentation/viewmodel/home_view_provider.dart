import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/home/domain/entities/committee_account.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/home/domain/usecases/get_subscribe_committee_usecase.dart';
import 'package:front/features/home/domain/usecases/get_today_bill_thumbnails_usecase.dart';
import 'package:front/dependency/service_locator.dart';

final getTodayBillThumbnailsUseCaseProvider = Provider<GetTodayBillThumbnailsUseCase>((ref) {
  return getIt<GetTodayBillThumbnailsUseCase>();
});

final todayBillThumbnailsProvider = FutureProvider<List<BillThumbnail>>((ref) async {
  final useCase = ref.watch(getTodayBillThumbnailsUseCaseProvider);
  final refreshTrigger = ref.watch(homeRefreshTriggerProvider); // refreshTrigger 감지
  return await useCase.fetch();
});

final getSubscribeCommitteeAccountUseCaseProvider = Provider<GetSubscribeCommitteeUseCase>((ref) {
  return getIt<GetSubscribeCommitteeUseCase>();
});

final subscribeCommitteeAccountFutureProvider = FutureProvider.autoDispose<List<SubscribeCommitteeInfo>>((ref) async {
  final useCase = ref.watch(getSubscribeCommitteeAccountUseCaseProvider);
  final refreshTrigger = ref.watch(homeRefreshTriggerProvider); // refreshTrigger 감지
  return await useCase.fetch();
});

final homeRefreshTriggerProvider = StateProvider<bool>((ref) => false);
