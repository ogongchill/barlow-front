import 'package:core/api/common/api_client.dart';
import 'package:core/api/common/params/api_request_params.dart';
import 'package:core/api/home/home_notification_response.dart';
import 'package:core/api/home/home_response.dart';

class HomeRouter {

  static const ApiRoute homeRoute = ApiRoute(
      path: 'api/v1/home',
      method: HttpMethod.get
  );
  static const ApiRoute notificationCenterRoute = ApiRoute(
      path: 'api/v1/home/notification-center',
      method: HttpMethod.get
  );

  final ApiClient _apiClient;

  HomeRouter(this._apiClient);

  Future<HomeResponse?> retrieveHome() => _apiClient.request(
    apiRoute: homeRoute,
    fromJson: (json) => HomeResponse.fromJson(json)
  );

  Future<HomeNotificationCenterResponse?> retrieveNotificationCenter({
    NotificationFilterQueryParameter? notificationFilterParam
  }) => _apiClient.request(
        apiRoute: notificationCenterRoute,
        fromJson: (json) => HomeNotificationCenterResponse.fromJson(json),
        params: notificationFilterParam != null
            ? notificationFilterParam.params
            : {}
        );
}
