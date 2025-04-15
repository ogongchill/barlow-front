import 'dart:math';

import 'package:front/features/notification/domain/entities/received_notificaton.dart';
import 'package:front/features/notification/domain/repositories/received_notification_repository.dart';

class DummyReceivedNotificationRepository implements ReceivedNotificationRepository {

  final List<ReceivedNotification> createdNotification = _createNotifications();

  @override
  Future<List<ReceivedNotification>> retrieveAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return notifications;
  }
}

List<ReceivedNotification> _createNotifications() {
  List<ReceivedNotification> notifications = [
    ReceivedNotification(
        topic: "topic1",
        title: "국회운영위원회",
        body: "조세특례제한법 일부 개정 법률안",
        billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
        receivedAt: DateTime.timestamp()
    )
  ];
  Random random = Random();
  for(int i = 0; i < 20; i ++) {
    notifications.add(
        ReceivedNotification(
            topic: "topic",
            title: "title",
            body: "body",
            billId: random.nextDouble().toString(),
            receivedAt: DateTime.now()
        )
    );
  }
  return notifications;
}

List<ReceivedNotification> notifications = [
ReceivedNotification(
    topic: "topic1",
    title: "국회운영위원회",
    body: "조세특례제한법 일부 개정 법률안",
    billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
    receivedAt: DateTime.timestamp()
  ),
  ReceivedNotification(
      topic: "topic2",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "3",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic3",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "4",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic4",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic5",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic6",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic7",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic8",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic9",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic10",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic11",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic12",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic13",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic14",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),ReceivedNotification(
      topic: "topic15",
      title: "국회운영위원회",
      body: "조세특례제한법 일부 개정 법률안",
      billId: "PRC_V2T5U0S3R0R5Z1Z3Y2Z6X5X3W7S8S5",
      receivedAt: DateTime.timestamp()
  ),
];