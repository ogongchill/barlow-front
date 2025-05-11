import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppSettingsRepository {

  Future<bool> isFirstLaunch();
  Future<void> setFirstLaunch(bool value);
  Future<bool> isLoggedIn();
  Future<void> setLoginStatus(bool value);
  Future<void> clear();
}

class SharedPrefsAppSettingRepository implements AppSettingsRepository{

  static const String _isFirstLaunchKey = "first_launch";
  static const String _isLoggedInKey = "is_logged_in";

  @override
  Future<bool> isFirstLaunch() async{
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool(_isFirstLaunchKey) ?? true;

    if (isFirst) {
      await prefs.setBool(_isFirstLaunchKey, false);
    }

    return isFirst;
  }

  @override
  Future<bool> isLoggedIn() async {
    return await SharedPreferences.getInstance()
        .then((pref) => pref.getBool(_isLoggedInKey) ?? false);
  }

  @override
  Future<void> setFirstLaunch(bool value) async {
    await SharedPreferences.getInstance()
        .then((pref) => pref.setBool(_isFirstLaunchKey, value));
  }

  @override
  Future<void> setLoginStatus(bool value) async {
    await SharedPreferences.getInstance()
        .then((pref) => pref.setBool(_isLoggedInKey, value));
  }

  @override
  Future<void> clear() async {
    await SharedPreferences.getInstance()
        .then((pref) {
          pref.setBool(_isFirstLaunchKey, true);
          pref.setBool(_isLoggedInKey, false);
    });
  }
}