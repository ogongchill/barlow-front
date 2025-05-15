import 'package:shared_preferences/shared_preferences.dart';

abstract interface class TermsAgreementRepository {

  Future<String?> getAgreementVersion();
  Future<void> saveAgreement(String version);
}

class TermsAgreementRepositoryAdapter implements TermsAgreementRepository {
  static const _key = 'agreed_terms_version';

  @override
  Future<void> saveAgreement(String version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, version);
  }

  @override
  Future<String?> getAgreementVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}