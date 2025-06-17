import 'package:core/api/api_router.dart';
import 'package:features/home/domain/entities/received_notificaton.dart';
import 'package:features/home/domain/repositories/received_notification_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReceivedNotificationRepository)
class ReceivedNotificationRepositoryAdapter implements ReceivedNotificationRepository {

  final ApiRouter _router;

  ReceivedNotificationRepositoryAdapter(this._router);

  @override
  Future<List<ReceivedNotification>> retrieveAll() async {
    final response = await _router.homeRouter.retrieveNotificationCenter();
    return response!.items
        .map((item) =>
          ReceivedNotification(
            topic: item.topic,
            title: item.title,
            body: item.body,
            billId: item.billId,
            receivedAt: item.createdAt
          )
        ).toList();
  }
}