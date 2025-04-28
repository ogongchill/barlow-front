import 'package:front/features/shared/domain/committee.dart';

abstract interface class CommitteeNotificationRepository {

  Future<void> activateNotification(Committee committee);

  Future<void> deactivateNotification(Committee committee);
}