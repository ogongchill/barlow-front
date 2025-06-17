import 'package:features/settings/domain/entities/user.dart';

abstract interface class UserInfoRepository {

  Future<UserInfo> retrieve();

  Future<void> setUserInfo(UserInfo userInfo);

  Future<void> deleteUserInfo();
}