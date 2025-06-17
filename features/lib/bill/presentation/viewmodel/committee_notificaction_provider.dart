import 'package:core/dependency/dependency_container.dart';
import 'package:features/bill/domain/entities/committe_notification.dart';
import 'package:features/bill/domain/usecases/committee_notification_usescase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final toggleCommitteeNotificationProvider =
FutureProvider.family<void, CommitteeNotification>((ref, committeeNotification) async {
  final useCase = dependencyContainer<ToggleCommitteeNotificationUseCase>();
  await useCase.execute(committeeNotification);
});

class ToggleCommitteeNotificationViewModel extends StateNotifier<AsyncValue<void>> {
  final ToggleCommitteeNotificationUseCase _useCase;

  ToggleCommitteeNotificationViewModel({required ToggleCommitteeNotificationUseCase useCase})
      : _useCase = useCase, super(const AsyncValue.data(null));

  Future<void> execute(CommitteeNotification committeeNotification) async {
    state = const AsyncValue.loading();
    try {
      await _useCase.execute(committeeNotification);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final toggleCommitteeNotificationViewModelProvider = Provider<ToggleCommitteeNotificationViewModel>((ref) {
  final useCase = dependencyContainer<ToggleCommitteeNotificationUseCase>();
  return ToggleCommitteeNotificationViewModel(useCase: useCase);
});
