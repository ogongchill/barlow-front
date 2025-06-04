import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/settings/domain/usecases/delete_guest_user_usecase.dart';

final deleteGuestUserFutureProvider = FutureProvider.autoDispose<void> ((ref) async {
  await getIt<DeleteGuestUserUseCase>().execute();
});