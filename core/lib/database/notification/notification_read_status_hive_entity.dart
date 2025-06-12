import 'package:hive/hive.dart';

part 'notification_read_status_hive_entity.g.dart';

@HiveType(typeId: 0)
class NotificationReadStatusHiveEntity extends HiveObject {

  @HiveField(0)
  String billId;

  @HiveField(1)
  DateTime receivedAt;

  @HiveField(2)
  bool isRead;

  NotificationReadStatusHiveEntity({
    required this.billId,
    required this.receivedAt,
    required bool? isRead
  }): isRead = isRead ?? false;
}