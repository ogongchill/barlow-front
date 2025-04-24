import 'package:front/features/shared/domain/bill_progress_status.dart';
import 'package:front/features/shared/domain/committee.dart';

abstract class NotificationTopic {

  final String value;

  NotificationTopic(this.value);
}

class CommitteeNotificationTopic extends NotificationTopic {

  final Committee committee;

  CommitteeNotificationTopic(this.committee): super(committee.name);
}

class ProgressNotificationTopic extends NotificationTopic {

  final ProgressStatus progressStatus;

  ProgressNotificationTopic(this.progressStatus): super(progressStatus.value);
}

class UserNotificationTopic extends NotificationTopic {

  static UserNotificationTopic reaction = UserNotificationTopic._("리액션");
  static UserNotificationTopic comment = UserNotificationTopic._("댓글");

  UserNotificationTopic._(super.value);
}