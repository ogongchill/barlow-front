import 'package:features/settings/domain/entities/user.dart';
import 'package:features/settings/domain/repositories/user_repository.dart';

class DummyUserInfoRepository implements UserInfoRepository {

  @override
  Future<UserInfo> retrieve() async {
    return UserInfo(userName: "userName", userId: "Guest_dsuaifvzcq1", role: UserRole.guest);
  }

  @override
  Future<void> setUserInfo(UserInfo userInfo) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserInfo() {
    throw UnimplementedError();
  }
}