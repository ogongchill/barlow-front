import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/settings/domain/entities/user.dart';
import 'package:front/features/settings/domain/usecases/load_user_info_usecase.dart';

final userInfoProvider = FutureProvider<UserInfo>(
    (ref) => getIt<LoadUserInfoUseCase>().execute()
);