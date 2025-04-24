import 'package:flutter_test/flutter_test.dart';
import 'package:front/core/api/common/notification_topics.dart';
import 'package:front/core/api/home/home_requests.dart';
import 'package:front/core/api/home/home_router.dart';
import 'package:front/features/shared/domain/committee.dart';

import '../core_api_test_config.dart';

void main() {
  HomeRouter homeRouter = HomeRouter(dioClient: bearerClient);
  test('home 요청', () async {
    final response = await homeRouter.home.send(HomeRequest());
    print(response.toJsonString());
  });
  test('home notification 요청', () async {
    Set<NotificationTopic> topics = {
          CommitteeNotificationTopic(Committee.houseSteering),
          CommitteeNotificationTopic(Committee.landInfrastructureAndTransport),
    };
    final response = await homeRouter.notificationCenter.send(HomeNotificationCenterRequest(topics));
    print(response.toJsonString());
  });
}