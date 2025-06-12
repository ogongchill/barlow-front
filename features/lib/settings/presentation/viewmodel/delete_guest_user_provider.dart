import 'package:core/dependency/service_locator.dart';
import 'package:features/settings/domain/usecases/delete_guest_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteGuestUserFutureProvider = FutureProvider.autoDispose<void> ((ref) async {
  await getIt<DeleteGuestUserUseCase>().execute();
});