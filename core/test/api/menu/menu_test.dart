import 'package:core/api/common/legislation_type.dart';
import 'package:core/api/constants/committee_param.dart';
import 'package:core/api/menu/menu_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_config.dart';

void main() {
  MenuRouter router = MenuRouter(mockClient);
  test("notification active 요청", () async {
    try {
      final response = await router.activateNotification(CommitteeLegislationType.of(CommitteeParam.houseSteering));
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
          CommitteeLegislationType.of(CommitteeParam.houseSteering));
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