import 'package:front/features/settings/domain/entities/user.dart';

abstract interface class UserRepository {

  Future<UserInfo> retrieve();
}