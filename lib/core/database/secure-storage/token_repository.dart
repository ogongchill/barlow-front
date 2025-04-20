import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class TokenRepository {

  Future<void> writeAccessToken(String token);
  Future<String?> readAccessToken();
  Future<void> deleteAccessToken();
  Future<void> writeRefreshToken(String token);
  Future<String?> readRefreshToken();
  Future<void> deleteRefreshToken();
  Future<void> clearAll();
}

class SecureStorageTokenRepository implements TokenRepository{

  static const _accessTokenKey = "accessToken";
  static const _refreshTokenKey = "refreshToken";
  static const _storage = FlutterSecureStorage();

  @override
  Future<void> writeAccessToken(String value) async {
    await _storage.write(key: _accessTokenKey, value: value);
  }

  @override
  Future<String?> readAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  @override
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  @override
  Future<void> writeRefreshToken(String value) async {
    await _storage.write(key: _refreshTokenKey, value: value);
  }

  @override
  Future<String?> readRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}