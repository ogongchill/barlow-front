import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/common/api_response.dart';

class AccountRouter {

  static const ApiRoute guestLoginRoute = ApiRoute(
      path: 'api/v1/account/withdraw',
      method: HttpMethod.post,
      requiresAuth: true
  );

  final ApiClient _apiClient;

  AccountRouter(this._apiClient);

  Future<void> withdraw() => _apiClient.request(
      apiRoute: guestLoginRoute,
      fromJson: (json) => EmptyResponse.fromJson(json));
}