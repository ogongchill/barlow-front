import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/committee/domain/entities/committe_notification.dart';
import 'package:front/features/committee/domain/usecases/committee_notification_usescase.dart';

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
    state = const AsyncValue.loading(); // ✅ 로딩 상태 반영
    try {
      await _useCase.execute(committeeNotification);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); // ✅ 에러 상태 반영
    }
  }
}

final toggleCommitteeNotificationViewModelProvider = Provider<ToggleCommitteeNotificationViewModel>((ref) {
  final useCase = getIt<ToggleCommitteeNotificationUseCase>();
  return ToggleCommitteeNotificationViewModel(useCase: useCase);
});
