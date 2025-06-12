import 'package:core/dependency/service_locator.dart';
import 'package:features/committee/domain/entities/committe_notification.dart';
import 'package:features/committee/domain/usecases/committee_notification_usescase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final toggleCommitteeNotificationProvider =
FutureProvider.family<void, CommitteeNotification>((ref, committeeNotification) async {
  final useCase = getIt<ToggleCommitteeNotificationUseCase>();
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
  final useCase = getIt<ToggleCommitteeNotificationUseCase>();
  return ToggleCommitteeNotificationViewModel(useCase: useCase);
});
