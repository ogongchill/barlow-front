import 'package:core/api/constants/committee_param.dart';
import 'package:core/api/constants/progress_status_param.dart';

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

  final CommitteeParam committeeType;

  CommitteeNotificationTopic(this.committeeType): super(committeeType.value);
}

class ProgressNotificationTopic extends NotificationTopic {

  final ProgressStatusParam progressStatus;

  ProgressNotificationTopic(this.progressStatus): super(progressStatus.value);
}

class UserNotificationTopic extends NotificationTopic {

  static UserNotificationTopic reaction = UserNotificationTopic._("REACTION");
  static UserNotificationTopic comment = UserNotificationTopic._("COMMENT");

  UserNotificationTopic._(super.value);
}