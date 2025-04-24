import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/api_response.dart';
import 'package:front/core/api/dio/dio.dart';
import 'package:front/core/api/home/home_notification_response.dart';
import 'package:front/core/api/home/home_requests.dart';
import 'package:front/core/api/home/home_response.dart';

class HomeRouter {

  final _Home _home;
  final _NotificationCenter _notificationCenter;

  HomeRouter({required DioClient dioClient})
   : _home = _Home(dioClient: dioClient),
     _notificationCenter = _NotificationCenter(dioClient: dioClient);

  ApiRequestEndpoint<HomeRequest, HomeResponse> get home => _home;
  ApiRequestEndpoint<HomeNotificationCenterRequest, HomeNotificationCenterResponse> get notificationCenter => _notificationCenter;
}


class _Home extends ApiRequestEndpoint<HomeRequest, HomeResponse> {

  _Home({required super.dioClient})
  : super(
    endpointPath: 'api/v1/home',
    method: Method.get
  );

  @override
  Future<HomeResponse> send(void request) async {
    final response = await dioClient.dio.get(endpointPath);
    Map<String, dynamic> responseBody = response.data;
    ApiResponse<HomeResponse> apiResponse = ApiResponse<HomeResponse>.fromJson(
      responseBody,
          (json) => HomeResponse.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data!;
  }
}

class _NotificationCenter extends ApiRequestEndpoint<HomeNotificationCenterRequest, HomeNotificationCenterResponse> {

  _NotificationCenter({required super.dioClient})
      : super(
      endpointPath: 'api/v1/home/notification-center',
      method: Method.get
  );

  @override
  Future<HomeNotificationCenterResponse> send(void request) async {
    final response = await dioClient.dio.get(endpointPath);
    Map<String, dynamic> responseBody = response.data;
    ApiResponse<HomeNotificationCenterResponse> apiResponse = ApiResponse<HomeNotificationCenterResponse>.fromJson(
      responseBody,
          (json) => HomeNotificationCenterResponse.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data!;
  }
}