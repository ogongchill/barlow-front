import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract interface class TokenRepository {

  Future<void> writeAccessToken(String token);
  Future<String?> readAccessToken();
  Future<void> deleteAccessToken();
  Future<void> clearAll();
}

@LazySingleton(as: TokenRepository)
class SecureStorageTokenRepository implements TokenRepository{

  static const _accessTokenKey = "accessToken";
  static const _storage = FlutterSecureStorage();

  String? accessTokenCache;

  @override
  Future<void> writeAccessToken(String value) async {
    await _storage.write(key: _accessTokenKey, value: value);
  }

  @override
  Future<String?> readAccessToken() async {
    if(accessTokenCache == null) {
      String? accessToken = await _storage.read(key: _accessTokenKey);
      accessTokenCache = accessToken;
      return accessToken;
    }
    return accessTokenCache;
  }

  @override
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
    accessTokenCache = null;
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
    accessTokenCache = null;
  }
}