import 'package:hive/hive.dart';

part 'user_info_hive_entity.g.dart';

@HiveType(typeId: 1)
class UserInfoHiveEntity {

  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String role;

  UserInfoHiveEntity({
    required this.userName,
    required this.userId,
    required this.role
  });
}