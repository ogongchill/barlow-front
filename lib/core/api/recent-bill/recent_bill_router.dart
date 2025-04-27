import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/common/api_request_params.dart';
import 'package:front/core/api/recent-bill/recent_bill_responses.dart';

class RecentBillRouter {

  static ApiRoute retrieveRecentBillThumbnailRoute() => const ApiRoute(
      path: 'api/v1/recent-bill/thumbnail',
      method: HttpMethod.get
  );

  static ApiRoute retrieveRecentBillDetailRoute(String billId) => ApiRoute(
      path: 'api/v1/recent-bill/detail/$billId',
      method: HttpMethod.get
  );

  final ApiClient _apiClient;

  RecentBillRouter(this._apiClient);

  Future<RecentBillThumbnailResponseBody?> retrieveRecentBillThumbnail({BillPostParams? params}) => _apiClient.request(
      apiRoute: retrieveRecentBillThumbnailRoute(),
      fromJson: (json) => RecentBillThumbnailResponseBody.fromJson(json),
      params: params != null ? params.params : {}
  );

  Future<RecentBillDetailResponseBody?> retrieveRecentBillDetail(String billId) => _apiClient.request(
      apiRoute: retrieveRecentBillDetailRoute(billId),
      fromJson: (json) => RecentBillDetailResponseBody.fromJson(json)
  );
}