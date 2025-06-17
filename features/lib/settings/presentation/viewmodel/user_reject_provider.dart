import 'package:core/dependency/dependency_container.dart';
import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/domain/usecases/check_reject_status_usecase.dart';
import 'package:features/settings/domain/usecases/mark_as_reject_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkUserRejectStatusProvider = FutureProvider.family.autoDispose<bool, UserRejectCategory> (
        (ref, userRejectCategory) => dependencyContainer<CheckUserRejectStatusUseCase>().execute(userRejectCategory)
);

final markAsRejectProvider = Provider.autoDispose<void Function(UserRejectCategory)> (
    (ref) => dependencyContainer<MarkAsRejectUseCase>().execute
);