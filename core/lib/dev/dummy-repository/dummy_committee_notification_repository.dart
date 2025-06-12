import 'dart:math';

import 'package:core/database/cache.dart';
import 'package:features/committee/domain/entities/committe_notification.dart';
import 'package:features/committee/domain/repositories/commitee_notification_repository.dart';
import 'package:features/shared/domain/committee.dart';

class DummyCommitteeNotificationRepository implements CommitteeNotificationRepository {

  final CommitteeNotificationCache _cache;
  final Map<Committee, bool> _notifications;

  DummyCommitteeNotificationRepository({required CommitteeNotificationCache cache, required Map<Committee, bool> notifications})
    : _cache = cache,
      _notifications = notifications;

    @override
    Future<void> activateNotification(Committee committee) async {
      print("POST : activateNotification");
      _cache.add(committee, true);
    }

  @override
  Future<void> deactivateNotification(Committee committee) async {
    print("POST : deactivateNotification");
    _cache.add(committee, false);
  }

  Future<CommitteeNotification> retrieveByCommittee(Committee committee) async {
    if(_cache.hit(committee)) {
      return CommitteeNotification(committee: committee, isActive: _cache.get(committee));
    }
    print("GET : fetching committee notifications");
    return CommitteeNotification(committee: committee, isActive: _notifications[committee]!);
  }
}

class DummyCommitteeNotificationRepositoryFactory {

  static CommitteeNotificationRepository withRandom({required CommitteeNotificationCache cache}) {
    return DummyCommitteeNotificationRepository(cache : cache, notifications: _createRandom());
  }

  static Map<Committee, bool> _createRandom() {
    Random random = Random();
    return Map<Committee, bool>.fromEntries(
        Committee.values
            .map( (committee) => MapEntry<Committee, bool>(committee, random.nextBool()))
    );
  }
}