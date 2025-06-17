import 'package:features/bill/domain/constant/committee.dart';

class CommitteeNotification {

  final Committee _committee;
  final bool _isActive;

  CommitteeNotification({required Committee committee, required bool isActive})
    : _committee = committee,
      _isActive = isActive;

  bool get isActive => _isActive;

  Committee get committee => _committee;
}