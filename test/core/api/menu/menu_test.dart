import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/core/api/menu/menu_router.dart';
import 'package:front/features/shared/domain/committee.dart';

import '../core_api_test_config.dart';

void main() {
  MenuRouter router = MenuRouter(mockClient);
  test("notification active 요청", () async {
    try {
      final response = await router.activateNotification(CommitteeLegislationType.of(Committee.houseSteering));
    } on DioException catch (e) {
      if(e.response?.statusCode == 409) {
        print("이미 알림설정됨");
      } else {
        rethrow;
      }
    }
  });

  test("notification deactive 요청", () async {
    try {
      final response = await router.deactivateNotification(
          CommitteeLegislationType.of(Committee.houseSteering));
    } on DioException catch (e) {
      if(e.response?.statusCode == 409) {
        print("이미 알림설정 끔");
      } else{
        rethrow;
      }
    };
  });

  test("notification retrieve 요청", () async {
    final response = await router.retrieveNotifications();
  });
}