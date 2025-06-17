import 'package:features/bill/domain/entities/bill_thumbnail.dart';

class SubscribeCommitteeInfo {
  final String name;
  final int legislationAccountNo;
  final String iconUrl;

  SubscribeCommitteeInfo({
    required this.name,
    required this.legislationAccountNo,
    required this.iconUrl
  });
}

class HomeInfo {

  final List<SubscribeCommitteeInfo> subscriptions;
  final List<BillThumbnail> thumbnails;
  final bool isNotificationArrived;

  HomeInfo({required this.subscriptions, required this.thumbnails, required this.isNotificationArrived});
}
