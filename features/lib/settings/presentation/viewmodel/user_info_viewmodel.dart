import 'package:core/dependency/service_locator.dart';
import 'package:features/settings/domain/entities/user.dart';
import 'package:features/settings/domain/usecases/load_user_info_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoProvider = FutureProvider.autoDispose<UserInfo>(
    (ref) => getIt<LoadUserInfoUseCase>().execute()
);