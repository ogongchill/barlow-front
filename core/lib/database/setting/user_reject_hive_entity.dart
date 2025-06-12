// import 'package:front/features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:hive/hive.dart';

part 'user_reject_hive_entity.g.dart';

@HiveType(typeId: 2)
class UserRejectHiveEntity {

  @HiveField(0)
  final String categoryName;

  @HiveField(1)
  final DateTime rejectedAt;

  @HiveField(2)
  final DateTime expiredAt;

  UserRejectHiveEntity({
    required this.categoryName,
    required this.rejectedAt,
    required this.expiredAt
  });

  UserReject toUserReject() {
    return UserReject(
      category: UserRejectCategory.findByName(categoryName),
      rejectedAt: rejectedAt,
      expiredAt: expiredAt
    );
  }
}