// import 'package:front/core/database/hive_configs.dart';
// import 'package:front/core/database/setting/user_reject_hive_entity.dart';
// import 'package:front/features/settings/domain/entities/user_reject.dart';
// import 'package:front/features/settings/domain/repositories/user_reject_repository.dart';

import 'package:core/database/hive_configs.dart';
import 'package:core/database/setting/user_reject_hive_entity.dart';
import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/domain/repositories/user_reject_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRejectRepository)
class UserRejectHiveRepositoryAdapter implements UserRejectRepository {
  
  static final _box = HiveBoxes.userRejectBox;
  
  @override
  Future<UserReject?> findByCategory(UserRejectCategory category) async {
    UserRejectHiveEntity? userRejectHiveEntity = _box.get(category.name);
    if(userRejectHiveEntity == null) {
      return null;
    }
    return userRejectHiveEntity.toUserReject();
  }

  @override
  Future<void> markAsReject(UserRejectCategory category, DateTime expiredAt) async {
    print("DEBUG: markAsReject : $category");
    UserRejectHiveEntity userRejectHiveEntity = UserRejectHiveEntity(
        categoryName: category.name, rejectedAt: DateTime.now(),
        expiredAt: expiredAt
    );
    _box.put(category.name, userRejectHiveEntity);
  }
}