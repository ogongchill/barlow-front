import 'dart:collection';

import 'package:core/database/setting/user_reject_hive_entity.dart';
import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/domain/repositories/user_reject_repository.dart';
//
// import 'package:front/core/database/setting/user_reject_hive_entity.dart';
// import 'package:front/features/settings/domain/entities/user_reject.dart';
// import 'package:front/features/settings/domain/repositories/user_reject_repository.dart';

class DummyUserRejectRepository implements UserRejectRepository {

  Map<String, UserRejectHiveEntity> map = HashMap();

  @override
  Future<UserReject?> findByCategory(UserRejectCategory category) async {
    final entity = map[category.name];
    if(entity == null) {
      print("[DEBUGG]: retrieve $category = null");
      return null;
    }
    print("[DEBUGG]: retrieve $category");
    return entity.toUserReject();
  }

  @override
  Future<void> markAsReject(UserRejectCategory category, DateTime expiredAt) async {
    print("[DEBUGG]: markAsReject $category at $expiredAt");
    UserRejectHiveEntity userRejectHiveEntity = UserRejectHiveEntity(
        categoryName: category.name, rejectedAt: DateTime.now(),
        expiredAt: expiredAt
    );
    map[category.name] = userRejectHiveEntity;
  }
}