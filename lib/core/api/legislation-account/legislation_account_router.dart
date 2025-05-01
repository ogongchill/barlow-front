import 'package:front/core/api/common/api_client.dart';
import 'package:front/core/api/common/api_request_params.dart';
import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/features/shared/domain/committee.dart';

import 'legislation_account_responses.dart';

class LegislationAccountRouter {

  static ApiRoute retrieveLegislationAccountBillPostThumbnailsRoute(Committee committee) => ApiRoute(
      path: 'api/v1/legislation-accounts/${committee.camelToUpperUnderscore()}/bill-posts',
      method: HttpMethod.get
  );

  static ApiRoute retrieveLegislationAccountBillDetailRoute(String billId) => ApiRoute(
      path: 'api/v1/legislation-accounts/bill-posts/$billId',
      method: HttpMethod.get
  );

  static ApiRoute retrieveProfileRoute(LegislationType legislationType) => ApiRoute(
    path: 'api/v1/legislation-accounts/${legislationType.value}/profile',
    method: HttpMethod.get
  );

  static ApiRoute retrieveCommitteeAccountsRoute() => const ApiRoute(
    path: 'api/v1/legislation-accounts/committees/info',
    method: HttpMethod.get
  );

  static ApiRoute activateSubscriptionRoute(LegislationType legislationType) => ApiRoute(
    path: 'api/v1/legislation-accounts/${legislationType.value}/subscribe/activate',
    method: HttpMethod.post
  );

  static ApiRoute deactivateSubscriptionRoute(LegislationType legislationType) => ApiRoute(
      path: 'api/v1/legislation-accounts/${legislationType.value}/subscribe/deactivate',
      method: HttpMethod.post
  );

  final ApiClient _apiClient;

  LegislationAccountRouter(this._apiClient);

  Future<LegislationAccountBillPostThumbnailsResponseBody?> retrieveLegislationAccountBillPostThumbnails({
    required Committee committee, BillPostParams? requestParams}) => _apiClient.request(
          apiRoute: retrieveLegislationAccountBillPostThumbnailsRoute(committee),
          params: requestParams != null
              ? requestParams.params
              : {},
          fromJson: (json) => LegislationAccountBillPostThumbnailsResponseBody.fromJson(json)
  );
  
  Future<LegislationAccountBillPostDetailResponseBody?> retrieveLegislationAccountBillPostDetail({required String billId}) => _apiClient.request(
          apiRoute: retrieveLegislationAccountBillDetailRoute(billId),
          fromJson: (json) => LegislationAccountBillPostDetailResponseBody.fromJson(json)
  );

  Future<LegislationAccountProfileResponseBody?> retrieveProfile(LegislationType legislationType) => _apiClient.request(
          apiRoute: retrieveProfileRoute(legislationType),
          fromJson: (json) => LegislationAccountProfileResponseBody.fromJson(json)
  );

  Future<CommitteeAccountResponseBody?> retrieveCommitteeAccounts() => _apiClient.request(
          apiRoute: retrieveCommitteeAccountsRoute(),
          fromJson: (json) => CommitteeAccountResponseBody.fromJson(json)
  );

  Future<void> activateSubscription(LegislationType legislationType) => _apiClient.request(
      apiRoute: activateSubscriptionRoute(legislationType),
      fromJson: (json) {}
  );

  Future<void> deactivateSubscription(LegislationType legislationType) => _apiClient.request(
      apiRoute: deactivateSubscriptionRoute(legislationType),
      fromJson: (json) {}
  );
}