import 'package:core/dependency/service_locator.dart';
import 'package:features/committee/domain/entities/committee_subscription.dart';
import 'package:features/committee/domain/usecases/committtee_subscription_usecase.dart';
import 'package:features/shared/domain/committee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchCommitteeSubscriptionUseCaseProvider = Provider<FetchCommitteeSubscriptionUseCase>((ref) {
  return getIt<FetchCommitteeSubscriptionUseCase>();
});

final committeeSubscriptionFutureProvider = FutureProvider.autoDispose<List<CommitteeSubscription>>((ref) async {
  final useCase = ref.watch(fetchCommitteeSubscriptionUseCaseProvider);
  return useCase.execute();
});

final toggleCommitteeSubscriptionProvider =
FutureProvider.family<void, CommitteeSubscription>((ref, committeeSubscription) async {
  final useCase = getIt<ToggleCommitteeSubscriptionUseCase>();
  await useCase.execute(committeeSubscription);
});

final toggleCommitteeSubscriptionViewModelProvider = Provider<ToggleCommitteeSubscriptionViewModel>((ref) {
  final useCase = getIt<ToggleCommitteeSubscriptionUseCase>();
  return ToggleCommitteeSubscriptionViewModel(useCase: useCase);
});

class ToggleCommitteeSubscriptionViewModel extends StateNotifier<AsyncValue<void>> {
  final ToggleCommitteeSubscriptionUseCase _useCase;

  ToggleCommitteeSubscriptionViewModel({required ToggleCommitteeSubscriptionUseCase useCase})
      : _useCase = useCase, super(const AsyncValue.data(null));

  Future<void> execute(CommitteeSubscription committeeSubscription) async {
    state = const AsyncValue.loading(); // ✅ 로딩 상태 반영
    try {
      await _useCase.execute(committeeSubscription);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); // ✅ 에러 상태 반영
    }
  }
}

final fireworkAnimationProvider = StateProvider.family.autoDispose<bool, Committee>((ref, committee) => false);

final subscribeButtonDisabledProvider = StateProvider.family<bool, Committee>((ref, committeeId) => false);

final notificationToggleAnimationProvider = StateProvider.family<bool, Committee>((ref, committee) => false);

final notificationButtonDisabledProvider = StateProvider.family<bool, Committee>((ref, committee) => false);
