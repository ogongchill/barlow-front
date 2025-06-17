import 'package:features/bill/domain/constant/committee.dart';

class CommitteeSubscription {

  final Committee _committee;
  bool _isSubscribed;

  CommitteeSubscription({required Committee committee, required bool isSubscribed})
    : _committee = committee, _isSubscribed = isSubscribed;

  Committee get committee => _committee;

  bool get isSubscribed => _isSubscribed;

  void subscribe() {
    _isSubscribed = true;
  }

  void unSubscribe() {
    _isSubscribed = false;
  }
}