import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/version/version_check_response.dart';

class VersionCheckRouter {

  static ApiRoute retrieveRecentBillThumbnailRoute() => const ApiRoute(
      path: 'api/v1/client-version/check',
      method: HttpMethod.get
  );

  final ApiClient _apiClient;

  VersionCheckRouter(this._apiClient);

  Future<VersionCheckResponseBody?> retrieveRecentBillThumbnail() => _apiClient.request(
      apiRoute: retrieveRecentBillThumbnailRoute(),
      fromJson: (json) => VersionCheckResponseBody.fromJson(json),
  );
}