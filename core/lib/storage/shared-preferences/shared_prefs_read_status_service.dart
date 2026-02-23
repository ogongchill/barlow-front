import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsReadStatusService {

  static const Duration _ttl = Duration(days: 7);
  static const String _keyPrefix = 'read_status_';

  static Future<void> markAsRead(String billId) async {
    final prefs = await SharedPreferences.getInstance();
    final value = jsonEncode({
      'isRead': true,
      'receivedAt': DateTime.now().toIso8601String(),
    });
    await prefs.setString('$_keyPrefix$billId', value);
  }

  static Future<bool> isRead(String billId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_keyPrefix$billId');
    if (raw == null) return false;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return map['isRead'] as bool? ?? false;
  }

  static Future<void> clean() async {
    final prefs = await SharedPreferences.getInstance();
    final cutoff = DateTime.now().subtract(_ttl);
    final expiredKeys = prefs
        .getKeys()
        .where((key) => key.startsWith(_keyPrefix))
        .where((key) {
          final raw = prefs.getString(key);
          if (raw == null) return true;
          final map = jsonDecode(raw) as Map<String, dynamic>;
          final receivedAt = DateTime.parse(map['receivedAt'] as String);
          return receivedAt.isBefore(cutoff);
        })
        .toList();
    for (final key in expiredKeys) {
      await prefs.remove(key);
    }
  }
}
