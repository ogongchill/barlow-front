import 'package:core/dependency/dependency_container.dart';
import 'package:features/settings/domain/usecases/delete_guest_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteGuestUserFutureProvider = FutureProvider.autoDispose<void> ((ref) async {
  await dependencyContainer<DeleteGuestUserUseCase>().execute();
});