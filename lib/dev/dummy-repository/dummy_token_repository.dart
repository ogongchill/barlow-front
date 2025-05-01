import 'package:front/core/database/secure-storage/token_repository.dart';

class DummyTokenRepository implements TokenRepository {

  @override
  Future<void> clearAll() {
    // TODO: implement clearAll
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccessToken() {
    // TODO: implement deleteAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRefreshToken() {
    // TODO: implement deleteRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<String?> readAccessToken() async {
    return "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJiYXJsb3ctY29yZS1hdXRoIiwibWVtYmVyTm8iOjgsInJvbGUiOiJHVUVTVCJ9.mBAfmIS9mB_ua5_zdj-EqWPzsgMfd0BRfDLACBzVWgumBJmSty3Mzp0wazNMO8lghC4Se6qvDFsSChd9ZLu71goyqWFuOUUyKkHL2aVCPkGviac9YCDlAxeYeb8TTie8J4Dyn5cWkhBhalm3VnQybcPyhIgtn-dHDHi1DbrEAxBnFrzIx1ZsW7Gr5HZ9YibHSx-Vgg3lYz8N1edSbhZ9RNdQZVe426o7QRxiXfBjNcozvzZ3mitOucTxgy4JTXMrfsHDisUKk85Q7P8rjxwPvNxv5mbslr319aMCnwsUw_UfUqmRFqe1MByHL7eLYe37o7ZIObu2p8YtSElS6L7Fsw";
  }

  @override
  Future<String?> readRefreshToken() {
    // TODO: implement readRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> writeAccessToken(String token) {
    // TODO: implement writeAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> writeRefreshToken(String token) {
    // TODO: implement writeRefreshToken
    throw UnimplementedError();
  }

}