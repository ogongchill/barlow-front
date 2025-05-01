import 'package:flutter_test/flutter_test.dart';
import 'package:front/core/api/home/home_router.dart';

import '../core_api_test_config.dart';

void main() {
  HomeRouter homeRouter = HomeRouter(mockClient);
  test('home 요청', () async {
    final response = await homeRouter.retrieveHome();
  });
  test('home notification 요청', () async {
    final response = await homeRouter.retrieveNotificationCenter(
        // notificationFilterParam: NotificationFilterParam({
        //   CommitteeNotificationTopic(Committee.intelligence),
        //   ProgressNotificationTopic(ProgressStatus.plenarySubmitted)
        // })
    );
  });
}