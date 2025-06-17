import 'dart:collection';
import 'package:core/dependency/dependency_container.dart';
import 'package:features/settings/domain/entities/notification.dart';
import 'package:features/settings/domain/usecases/notification_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final useCase = dependencyContainer<FetchNotificationUseCase>();
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
    final useCase = dependencyContainer<ChangeNotificationUseCase>();
    isActive
        ? useCase.activate(notificationType)
        : useCase.deactivate(notificationType);
  }
}

final notificationToggleProvider = StateNotifierProvider<NotificationToggleStateNotifier, NotificationToggleState>(
      (ref) => NotificationToggleStateNotifier(),
);
