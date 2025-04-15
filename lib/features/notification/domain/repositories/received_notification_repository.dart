import 'package:front/features/notification/domain/entities/received_notificaton.dart';

abstract interface class ReceivedNotificationRepository {

  Future<List<ReceivedNotification>> retrieveAll();
}