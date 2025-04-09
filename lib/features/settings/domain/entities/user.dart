class UserInfo {

  final String userName;
  final String userId;
  final UserRole role;

  UserInfo({required this.userName, required this.userId, required this.role});
}

enum UserRole {

  guest,
  realNameVerified,
  ;
}