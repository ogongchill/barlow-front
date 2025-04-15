import 'package:flutter_riverpod/flutter_riverpod.dart';

class PushNotificationStateNotifier extends StateNotifier<bool> {

  PushNotificationStateNotifier(super.state);

  void unread() {
    state = false;
  }

  void read() {
    state = true;
  }
}

final pushNotificationStateProvider = StateNotifierProvider<PushNotificationStateNotifier, bool>(
    (ref) => PushNotificationStateNotifier(false)
);