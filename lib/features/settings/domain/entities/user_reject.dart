enum UserRejectCategory {
  notificationPermissionDialog,
  updateAvailableDialog,
  ;

  static UserRejectCategory findByName(String target) {
    return UserRejectCategory.values
        .firstWhere((category) => category.name == target);
  }
}

class UserReject {

  final UserRejectCategory category;
  final DateTime rejectedAt;
  final DateTime expiredAt;

  UserReject({required this.category, required this.rejectedAt, required this.expiredAt});
}