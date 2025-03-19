import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/committee/domain/entities/committee_subscription.dart';
import 'package:front/features/committee/domain/usecases/committtee_subscription_usecase.dart';
import 'package:front/features/shared/domain/committee.dart';


final fetchCommitteeSubscriptionUseCaseProvider = Provider<FetchCommitteeSubscriptionUseCase>((ref) {
  return getIt<FetchCommitteeSubscriptionUseCase>();
});

final committeeSubscriptionFutureProvider = FutureProvider<List<CommitteeSubscription>>((ref) async {
  final useCase = ref.watch(fetchCommitteeSubscriptionUseCaseProvider);
  return useCase.execute();
});

final singleCommitteeSubscriptionFutureProvider = FutureProvider.family<CommitteeSubscription, Committee>((ref, target) async {
  // ✅ 먼저 캐싱된 데이터 확인
  final asyncSubscriptions = ref.watch(committeeSubscriptionFutureProvider);

  List<CommitteeSubscription> subscriptions;

  if (asyncSubscriptions.hasValue) {
    // ✅ 캐싱된 데이터가 있으면 사용
    subscriptions = asyncSubscriptions.value!;
  } else {
    // ✅ 없으면 FetchUseCase 실행
    final useCase = ref.watch(fetchCommitteeSubscriptionUseCaseProvider);
    subscriptions = await useCase.execute();
  }

  // ✅ 데이터가 존재하면 반환, 없으면 예외 발생
  return subscriptions.firstWhere(
        (subscription) => subscription.committee == target,
    orElse: () => throw Exception("Subscription not found for committee: ${target.name}"),
  );
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

final thumbAnimationProvider = StateProvider.family<bool, Committee>((ref, committee) => false);
final thumbUpAnimationProvider = StateProvider.family<bool, Committee>((ref, committeeId) => false);
