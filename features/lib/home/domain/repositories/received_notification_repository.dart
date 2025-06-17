import 'package:features/home/domain/entities/received_notificaton.dart';

abstract interface class ReceivedNotificationRepository {

  Future<List<ReceivedNotification>> retrieveAll();
}