import 'package:features/bill/domain/constant/committee.dart';
import 'package:features/bill/domain/entities/committee_profile.dart';
import 'package:features/bill/domain/entities/committee_subscription.dart';
import 'package:injectable/injectable.dart';

abstract class Cache<K,V> {

  void add(K key, V value);
  bool hit(K key);
  V get(K key);
  void _cleanUp(K key);
}

@LazySingleton()
class CommitteeNotificationCache implements Cache<Committee, bool>{

  static const Duration ttl = Duration(milliseconds: 100000);
  final Map<Committee, bool> _notifications = {};
  final Map<Committee, DateTime> _expirationTimes = {};

  @override
  void add(Committee committee, bool isNotificationActive) {
    _notifications[committee] = isNotificationActive;
    _expirationTimes[committee] = DateTime.now().add(ttl);
  }


  @override
  bool hit(Committee committee) {
    final int nowMs = DateTime.now().millisecondsSinceEpoch; // 한 번만 가져오기

    final expirationTime = _expirationTimes[committee];
    if (expirationTime == null || nowMs >= expirationTime.millisecondsSinceEpoch) {
      _cleanUp(committee);
      return false;
    }
    return true;
  }

  @override
  bool get(Committee committee) {
    if(_notifications[committee] == null) {
      throw StateError("no such committee, call hit(<committee>) before call get(<committee>)");
    }
    return _notifications[committee]!;
  }

  @override
  void _cleanUp(Committee committee) {
    _notifications.remove(committee);
    _expirationTimes.remove(committee);
  }
}

@LazySingleton()
class CommitteeSubscriptionCache implements Cache<Committee, bool>{

  static const Duration ttl = Duration(milliseconds: 100000);
  final Map<Committee, bool> _subscriptions = {};
  final Map<Committee, DateTime> _expirationTimes = {};

  @override
  void add(Committee committee, bool isSubscribed) {
    _subscriptions[committee] = isSubscribed;
    _expirationTimes[committee] = DateTime.now().add(ttl);
  }


  @override
  bool hit(Committee committee) {
    final int nowMs = DateTime.now().millisecondsSinceEpoch; // 한 번만 가져오기

    final expirationTime = _expirationTimes[committee];
    if (expirationTime == null || nowMs >= expirationTime.millisecondsSinceEpoch) {
      _cleanUp(committee);
      return false;
    }
    return true;
  }

  @override
  bool get(Committee committee) {
    if(_subscriptions[committee] == null) {
      throw StateError("no such committee, call hit(<committee>) before call get(<committee>)");
    }
    return _subscriptions[committee]!;
  }

  @override
  void _cleanUp(Committee committee) {
    _subscriptions.remove(committee);
    _expirationTimes.remove(committee);
  }

  bool hasAll() {
    return _subscriptions.length == 18;
  }

  List<CommitteeSubscription> getAll() {
    return _subscriptions.entries
        .map((entry) => CommitteeSubscription(committee: entry.key, isSubscribed: entry.value))
        .toList();
  }

  void addAll(List<CommitteeSubscription> subscriptions) {
    final expiration = DateTime.now().add(ttl);
    _subscriptions.addEntries(
        subscriptions.map((subscription) => MapEntry(subscription.committee, subscription.isSubscribed))
    );
    _expirationTimes.addEntries(
        subscriptions.map((subscription) => MapEntry(subscription.committee, expiration))
    );
  }
}

@LazySingleton()
class CommitteeProfileCache implements Cache<Committee, CommitteeProfile>{

  static const Duration ttl = Duration(milliseconds: 100000);
  final Map<Committee, CommitteeProfile> _profiles = {};
  final Map<Committee, DateTime> _expirationTimes = {};

  @override
  void add(Committee committee, CommitteeProfile profile) {
    _profiles[committee] = profile;
    _expirationTimes[committee] = DateTime.now().add(ttl);
  }


  @override
  bool hit(Committee committee) {
    final int nowMs = DateTime.now().millisecondsSinceEpoch; // 한 번만 가져오기

    final expirationTime = _expirationTimes[committee];
    if (expirationTime == null || nowMs >= expirationTime.millisecondsSinceEpoch) {
      _cleanUp(committee);
      return false;
    }
    return true;
  }

  @override
  CommitteeProfile get(Committee committee) {
    if(_profiles[committee] == null) {
      throw StateError("no such committee, call hit(<committee>) before call get(<committee>)");
    }
    return _profiles[committee]!;
  }

  @override
  void _cleanUp(Committee committee) {
    _profiles.remove(committee);
    _expirationTimes.remove(committee);
  }
}
