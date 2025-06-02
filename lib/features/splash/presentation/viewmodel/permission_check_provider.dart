import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/splash/domain/usecases/check_notification_permission_permanently_denied_usecase.dart';
import 'package:front/features/splash/domain/usecases/mark_as_check_notification_permission_usecase.dart';
import 'package:front/features/splash/domain/usecases/request_notification_permission_usecase.dart';

final requestNotificationPermissionProvider = FutureProvider<void>((ref) => getIt<RequestNotificationPermissionUseCase>().execute());
final notificationPermissionCheckStatusProvider = StateProvider.autoDispose<bool>((ref)=>false);
final checkNotificationPermissionStatusProvider = FutureProvider.autoDispose<PermissionStatus>((ref) => CheckNotificationPermissionStatusUseCase.execute());
final markAsCheckNotificationPermissionProvider = Provider<void Function()>((ref) {
  return () {
    getIt<MarkAsCheckNotificationPermissionUseCase>().execute();
  };
});