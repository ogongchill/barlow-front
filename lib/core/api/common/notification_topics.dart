import 'package:front/features/shared/domain/bill_progress_status.dart';
import 'package:front/features/shared/domain/committee.dart';

abstract class NotificationTopic {

  final String value;

  NotificationTopic(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTopic &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class CommitteeNotificationTopic extends NotificationTopic {

  final Committee committee;

  CommitteeNotificationTopic(this.committee): super(committee.camelToUpperUnderscore());
}

class ProgressNotificationTopic extends NotificationTopic {

  final ProgressStatus progressStatus;

  ProgressNotificationTopic(this.progressStatus): super(progressStatus.upperCaseWithUnderscore);
}

class UserNotificationTopic extends NotificationTopic {

  static UserNotificationTopic reaction = UserNotificationTopic._("REACTION");
  static UserNotificationTopic comment = UserNotificationTopic._("COMMENT");

  UserNotificationTopic._(super.value);
}