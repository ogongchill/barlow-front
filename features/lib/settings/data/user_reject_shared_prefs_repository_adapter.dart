import 'dart:convert';

import 'package:features/settings/domain/entities/user_reject.dart';
import 'package:features/settings/domain/repositories/user_reject_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: UserRejectRepository)
class UserRejectSharedPrefsRepositoryAdapter implements UserRejectRepository {

  static const String _keyPrefix = 'user_reject_';

  @override
  Future<UserReject?> findByCategory(UserRejectCategory category) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_keyPrefix${category.name}');
    if (raw == null) return null;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return UserReject(
      category: UserRejectCategory.findByName(map['categoryName'] as String),
      rejectedAt: DateTime.parse(map['rejectedAt'] as String),
      expiredAt: DateTime.parse(map['expiredAt'] as String),
    );
  }

  @override
  Future<void> markAsReject(UserRejectCategory category, DateTime expiredAt) async {
    print("DEBUG: markAsReject : $category");
    final prefs = await SharedPreferences.getInstance();
    final value = jsonEncode({
      'categoryName': category.name,
      'rejectedAt': DateTime.now().toIso8601String(),
      'expiredAt': expiredAt.toIso8601String(),
    });
    await prefs.setString('$_keyPrefix${category.name}', value);
  }
}
