import 'package:features/shared/domain/committee.dart';

class CommitteeProfile {

  final Committee _committee;
  final String _description;
  final int _postCount;
  final int _subscriberCount;
  final bool _isSubscribed;
  final bool _isNotificationActive;

  CommitteeProfile({
    required Committee committee,
    required String description,
    required int postCount,
    required int subscriberCount,
    required bool isSubscribed,
    required bool isNotificationActive})
      : _committee = committee,
        _description = description,
        _postCount = postCount,
        _subscriberCount = subscriberCount,
        _isSubscribed = isSubscribed,
        _isNotificationActive = isNotificationActive;

  bool get isNotificationActive => _isNotificationActive;

  bool get isSubscribed => _isSubscribed;

  int get subscriberCount => _subscriberCount;

  int get postCount => _postCount;

  String get description => _description;

  Committee get committee => _committee;
}