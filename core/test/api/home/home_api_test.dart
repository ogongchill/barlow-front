import 'package:core/api/home/home_router.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_config.dart';


void main() {
  HomeRouter homeRouter = HomeRouter(mockClient);

  test('home 요청', () async {
    final response = await homeRouter.retrieveHome();
  });

  test('home notification 요청', () async {
    final response = await homeRouter.retrieveNotificationCenter(
    );
  });
}