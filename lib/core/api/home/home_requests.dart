import 'package:front/core/api/common/api_request.dart';
import 'package:front/core/api/common/notification_topics.dart';

class HomeRequest extends QueryRequest{
  HomeRequest() : super({});
}

class HomeNotificationCenterRequest extends QueryRequest {
  static const _filterName = 'filterTopic';

  HomeNotificationCenterRequest(Set<NotificationTopic> notificationTopics)
  : super({
    _filterName : notificationTopics.map((topic) => topic.value).toList()
  });
}