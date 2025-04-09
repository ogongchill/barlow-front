import 'package:front/features/settings/domain/entities/user.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';

class DummyUserInfoRepository implements UserRepository {

  @override
  Future<UserInfo> retrieve() async {
    return UserInfo(userName: "userName", userId: "Guest_dsuaifvzcq1", role: UserRole.guest);
  }
}