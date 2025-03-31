import 'package:front/features/committee/domain/entities/committe_notification.dart';
import 'package:front/features/shared/domain/committee.dart';

abstract class CommitteeNotificationRepository {

  Future<CommitteeNotification> retrieveByCommittee(Committee committee);

  Future<void> activateNotification(Committee committee);

  Future<void> deactivateNotification(Committee committee);
}