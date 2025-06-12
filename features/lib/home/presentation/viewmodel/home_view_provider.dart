import 'package:core/dependency/service_locator.dart';
import 'package:features/home/domain/entities/committee_account.dart';
import 'package:features/home/domain/usecases/get_home_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRefreshTriggerProvider = StateProvider<bool>((ref) => false);

final getHomeInfoFutureProvider = FutureProvider.autoDispose<HomeInfo> ((ref) async {
  final refreshTrigger = ref.watch(homeRefreshTriggerProvider); // refreshTrigger 감지
  return getIt<GetHomeUseCase>().execute();
});