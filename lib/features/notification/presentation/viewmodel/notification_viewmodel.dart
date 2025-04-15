import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/notification/domain/entities/received_notificaton.dart';
import 'package:front/features/notification/domain/usecases/fetch_received_notification_usecase.dart';
import 'package:front/features/notification/domain/usecases/notification_read_status_usecase.dart';

final receivedNotificationFutureProvider = FutureProvider.autoDispose<List<ReceivedNotification>>( (ref) async {
  final useCase = getIt<FetchReceivedNotificationUseCase>();
  return useCase.execute();
});

final readStatusProvider = FutureProvider.family.autoDispose<bool, String>((ref, billId) {
  final useCase = getIt<CheckIsReadNotificationUseCase>();
  return useCase.execute(billId);
});

final markAsRead = Provider.family.autoDispose<void Function(), String>((ref, billId) {
  final useCase = getIt<MarkAsReadNotificationUseCase>();
  return () {
    useCase.execute(billId); // Fire-and-forget
  };
});

final notificationReadStatusProvider = StateNotifierProvider.autoDispose<NotificationReadStatusNotifier, UnmodifiableMapView<String, bool>>(
      (ref) => NotificationReadStatusNotifier(
    getIt<CheckIsReadNotificationUseCase>(),
    getIt<MarkAsReadNotificationUseCase>(),
  ),
);

class NotificationReadStatusNotifier extends StateNotifier<UnmodifiableMapView<String, bool>> {
  final CheckIsReadNotificationUseCase _checkUseCase;
  final MarkAsReadNotificationUseCase _markUseCase;

  NotificationReadStatusNotifier(
      this._checkUseCase,
      this._markUseCase,
      ) : super(UnmodifiableMapView({}));

  Future<void> load(String billId) async {
    final isAlreadyLoaded = state.containsKey(billId);
    final previous = state[billId];

    if (isAlreadyLoaded && previous == true) return;

    final result = await _checkUseCase.execute(billId);

    if (result == previous) return;

    state = UnmodifiableMapView({...state, billId: result});
  }

  Future<void> markAsRead(String billId) async {
    await _markUseCase.execute(billId);
    state = UnmodifiableMapView({...state, billId: true});
  }

  bool isRead(String billId) => state[billId] ?? false;
}
