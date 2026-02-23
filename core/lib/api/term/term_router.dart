import 'package:core/api/common/api_client.dart';
import 'package:core/api/term/active_term_response.dart';

class TermRouter {

  static ApiRoute retrieveActiveTermsRoute() => const ApiRoute(
      path: 'api/v1/term/active',
      method: HttpMethod.get
  );

  final ApiClient _apiClient;

  TermRouter(this._apiClient);

  Future<ActiveTermResponse?> retrieveCurrentActiveTerms() => _apiClient.request(
    apiRoute: retrieveActiveTermsRoute(),
    fromJson: (json) => ActiveTermResponse.fromJson(json),
  );
}