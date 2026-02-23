import 'dart:convert';

import 'package:features/settings/domain/entities/user.dart';
import 'package:features/settings/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: UserInfoRepository)
class UserInfoSharedPrefsRepository implements UserInfoRepository {

  static const String _key = 'user_info';

  @override
  Future<UserInfo> retrieve() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) {
      throw StateError("user entity가 조회되지 않습니다.");
    }
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return UserInfo(
      userName: map['userName'] as String,
      userId: map['userId'] as String,
      role: map['role'] == 'guest' ? UserRole.guest : UserRole.unknown,
    );
  }

  @override
  Future<void> setUserInfo(UserInfo userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    final value = jsonEncode({
      'userName': userInfo.userName,
      'userId': userInfo.userId,
      'role': userInfo.role.name,
    });
    await prefs.setString(_key, value);
  }

  @override
  Future<void> deleteUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
