import 'package:core/api/common/api_client.dart';
import 'package:core/api/pre-announce/pre_announce_request_param.dart';
import 'package:core/api/pre-announce/pre_announce_responses.dart';

class PreAnnounceRouter {
  
  static ApiRoute retrievePreAnnouncementBillThumbnailRoute() => const ApiRoute(
      path: 'api/v1/pre-announcement-bills', 
      method: HttpMethod.get
  );
  
  static ApiRoute retrievePreAnnouncementBillDetailRoute(String billId) => ApiRoute(
      path: 'api/v1/pre-announcement-bills/$billId', 
      method: HttpMethod.get
  ); 
  
  final ApiClient _apiClient;
  
  PreAnnounceRouter(this._apiClient);
  
  Future<PreAnnounceBillPostsResponseBody?> retrievePreAnnouncementBillThumbnail({PreAnnounceParam? param}) => _apiClient.request(
      apiRoute: retrievePreAnnouncementBillThumbnailRoute(), 
      fromJson: (json) => PreAnnounceBillPostsResponseBody.fromJson(json),
      params: param != null ? param.params : {}
  );
  
  Future<PreAnnounceBillPostsDetailResponseBody?> retrievePreAnnouncementBillDetail(String billId) => _apiClient.request(
      apiRoute: retrievePreAnnouncementBillDetailRoute(billId), 
      fromJson: (json) => PreAnnounceBillPostsDetailResponseBody.fromJson(json)
  );
}