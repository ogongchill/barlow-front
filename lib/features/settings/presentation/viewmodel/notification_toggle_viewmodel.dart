import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/settings/domain/entities/notification.dart';
import 'package:front/features/settings/domain/usecases/notification_usecase.dart';

class NotificationToggleState {
  final UnmodifiableMapView<NotificationType, bool> notifications;
  final bool isToggleEnabled;
  final bool isInitialized;

  const NotificationToggleState({
    required this.notifications,
    required this.isToggleEnabled,
    this.isInitialized = false,
  });

  NotificationToggleState copyWith({
    Map<NotificationType, bool>? notifications,
    bool? isToggleEnabled,
    bool? isInitialized,
  }) {
    return NotificationToggleState(
      notifications: UnmodifiableMapView(notifications ?? this.notifications),
      isToggleEnabled: isToggleEnabled ?? this.isToggleEnabled,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}


class NotificationToggleStateNotifier extends StateNotifier<NotificationToggleState> {

  static const _coolDown = Duration(milliseconds: 1000);

  NotificationToggleStateNotifier()
      : super(NotificationToggleState(
    notifications: UnmodifiableMapView({}),
    isToggleEnabled: true,
    isInitialized: false
  ));

  Future<void> initialize() async {
    final useCase = getIt<FetchNotificationUseCase>();
    final result = await useCase.execute();
    debugPrint("알림 초기화: ${result.length}개 - $result");
    state = state.copyWith(
      notifications: result,
      isToggleEnabled: true,
      isInitialized: true
    );
  }

  void toggle(NotificationType notificationType) {
    if (!state.isToggleEnabled) return;

    final currentMap = Map<NotificationType, bool>.from(state.notifications);
    final currentValue = currentMap[notificationType] ?? false;
    final newValue = !currentValue;
    currentMap[notificationType] = newValue;
    currentMap[notificationType] = newValue;

    // api 요청
    _syncWithRepository(notificationType, newValue);

    state = state.copyWith(
      notifications: currentMap,
      isToggleEnabled: false,
    );

    // 쿨다운 적용
    Future.delayed(_coolDown, () {
      state = state.copyWith(isToggleEnabled: true);
    });
  }

  void _syncWithRepository(NotificationType notificationType, bool isActive) {
    final useCase = getIt<ChangeNotificationUseCase>();
    isActive
        ? useCase.activate(notificationType)
        : useCase.deactivate(notificationType);
  }
}

final notificationToggleProvider = StateNotifierProvider<NotificationToggleStateNotifier, NotificationToggleState>(
      (ref) => NotificationToggleStateNotifier(),
);
