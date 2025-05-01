import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/splash/domain/entities/app_initialize_info.dart';
import 'package:front/features/splash/domain/usecases/login_usecase.dart';
import 'package:front/features/splash/domain/usecases/retrieve_app_initialize_info_usecase.dart';
import 'package:front/features/splash/domain/usecases/sign_up_usecase.dart';

final appInitializeInfoProvider = FutureProvider<AppInitializeInfo>((ref) async {
  return getIt<RetrieveAppInitializeInfoUseCase>().execute();
});

final loginUseCaseProvider = FutureProvider<void>((ref) async {
  return getIt<LoginUseCase>().execute();
});

final signupUseCaseProvider = FutureProvider.family<void, String>((ref, nickname) async {
  return getIt<SignupUseCase>().execute(nickname);
});