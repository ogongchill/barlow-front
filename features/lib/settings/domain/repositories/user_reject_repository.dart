import 'package:features/settings/domain/entities/user_reject.dart';

abstract interface class UserRejectRepository {

  Future<UserReject?> findByCategory(UserRejectCategory category);

  Future<void> markAsReject(UserRejectCategory category, DateTime expiredAt);
}