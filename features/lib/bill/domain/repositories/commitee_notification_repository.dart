import 'package:features/bill/domain/constant/committee.dart';

abstract interface class CommitteeNotificationRepository {

  Future<void> activateNotification(Committee committee);

  Future<void> deactivateNotification(Committee committee);
}