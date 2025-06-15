import 'package:core/database/hive_configs.dart';
import 'package:core/database/user/user_info_hive_entity.dart';
import 'package:features/settings/domain/entities/user.dart';
import 'package:features/settings/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserInfoRepository)
class UserInfoHiveRepository implements UserInfoRepository {

  static final _box = HiveBoxes.userInfoBox;
  static const  String _key = 'user';

  @override
  Future<UserInfo> retrieve() async {
    UserInfoHiveEntity? entity = _box.get(_key);
    if(entity == null) {
      throw StateError("user entity가 조회되지 않습니다.");
    }
    return UserInfo(userName: entity.userName, userId: entity.userId, role: entity.role == 'guest' ? UserRole.guest : UserRole.unknown);
  }

  @override
  Future<void> setUserInfo(UserInfo userInfo) async {
    await _box.put(_key, UserInfoHiveEntity(userName: userInfo.userName, userId: userInfo.userId, role: userInfo.role.name));
  }

  @override
  Future<void> deleteUserInfo() async{
    await _box.clear();
  }
}