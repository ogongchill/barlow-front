abstract interface class AuthRepository {

  Future<String> guestLogin();
  Future<String> guestSingUp(String id, String nickname);
}