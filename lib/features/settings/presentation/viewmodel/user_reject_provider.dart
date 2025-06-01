import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/settings/domain/entities/user_reject.dart';
import 'package:front/features/settings/domain/usecases/check_reject_status_usecase.dart';
import 'package:front/features/settings/domain/usecases/mark_as_reject_usecase.dart';

final checkUserRejectStatusProvider = FutureProvider.family.autoDispose<bool, UserRejectCategory> (
        (ref, userRejectCategory) => getIt<CheckUserRejectStatusUseCase>().execute(userRejectCategory)
);

final markAsRejectProvider = Provider.autoDispose<void Function(UserRejectCategory)> (
    (ref) => getIt<MarkAsRejectUseCase>().execute
);