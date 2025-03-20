import 'package:front/features/shared/domain/committee.dart';

class CommitteeAccountInfo {

  final Committee _committee;
  final int _postCount;
  final int _subscriptionCount;
  final String _description;

  CommitteeAccountInfo({required Committee committee, required int postCount, required int subscriptionCount, required String description})
    : _committee = committee,
      _postCount = postCount,
      _subscriptionCount = subscriptionCount,
      _description = description;

  String get description => _description;

  int get subscriptionCount => _subscriptionCount;

  int get postCount => _postCount;

  Committee get committee => _committee;
}