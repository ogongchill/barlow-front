import 'package:front/features/settings/domain/entities/user.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';

class DummyUserInfoRepository implements UserInfoRepository {

  @override
  Future<UserInfo> retrieve() async {
    return UserInfo(userName: "userName", userId: "Guest_dsuaifvzcq1", role: UserRole.guest);
  }

  @override
  Future<void> setUserInfo(UserInfo userInfo) {
    // TODO: implement setUserInfo
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserInfo() {
    // TODO: implement deleteUserInfo
    throw UnimplementedError();
  }
}