import 'package:core/api/common/api_client.dart';
import 'package:core/api/common/api_response.dart';
import 'package:core/api/common/legislation_type.dart';
import 'package:core/api/menu/menu_responses.dart';

class MenuRouter {

  static ApiRoute activeNotificationRoute(LegislationType legislationType) => ApiRoute(
      path: 'api/v1/menu/notifications/${legislationType.value}/activate',
      method: HttpMethod.post
  );

  static ApiRoute deactivateNotificationRoute(LegislationType legislationType) => ApiRoute(
    path: 'api/v1/menu/notifications/${legislationType.value}/deactivate',
    method: HttpMethod.post
  );

  static ApiRoute retrieveNotificationRoute() => const ApiRoute(
    path: 'api/v1/menu/notifications',
    method: HttpMethod.get
  );

  final ApiClient _apiClient;

  MenuRouter(this._apiClient);

  Future<void> activateNotification(LegislationType legislationType) => _apiClient.request(
      apiRoute: activeNotificationRoute(legislationType),
      fromJson: (json) => EmptyResponse.fromJson(json)
  );

  Future<void> deactivateNotification(LegislationType legislationType) => _apiClient.request(
      apiRoute: deactivateNotificationRoute(legislationType),
      fromJson: (json) => EmptyResponse.fromJson(json)
  );

  Future<NotificationMenuResponseBody?> retrieveNotifications() => _apiClient.request(
      apiRoute: retrieveNotificationRoute(),
      fromJson: (json) => NotificationMenuResponseBody.fromJson(json)
  );
}