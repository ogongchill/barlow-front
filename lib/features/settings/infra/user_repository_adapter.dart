import 'package:front/core/api/api_router.dart';
import 'package:front/features/settings/domain/entities/user.dart';
import 'package:front/features/settings/domain/repositories/user_repository.dart';

class UserRepositoryAdapter implements UserRepository {

  final ApiRouter _router;

  UserRepositoryAdapter(this._router);

  @override
  Future<UserInfo> retrieve() {

    throw UnimplementedError();
  }
}