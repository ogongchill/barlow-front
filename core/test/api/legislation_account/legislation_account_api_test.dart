import 'package:core/api/api_exception.dart';
import 'package:core/api/common/legislation_type.dart';
import 'package:core/api/common/params/api_request_params.dart';
import 'package:core/api/common/params/page_param.dart';
import 'package:core/api/common/params/sort_key_query_parameter.dart';
import 'package:core/api/constants/bill_proposer_param.dart';
import 'package:core/api/constants/committee_param.dart';
import 'package:core/api/constants/party_param.dart';
import 'package:core/api/constants/progress_status_param.dart';
import 'package:core/api/legislation-account/legislation_account_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_config.dart';

void main() {

  LegislationAccountRouter service = LegislationAccountRouter(mockClient);
  test('소관위원회 bill-post thumbnail요청', () async {
    final response = await service.retrieveLegislationAccountBillPostThumbnails(
        committee: CommitteeParam.landInfrastructureAndTransport,
        requestParams: BillPostQueryParameter.from(
            pagingParam: PageQueryParam(0, 10),
            sortKeyParam: SortKeyQueryParam(SortKey.createdAtAsc),
            billPostFilterParam: BillPostFilterParam(
                legislationType: LegislationTypeFilter({CommitteeLegislationType.of(CommitteeParam.nationalDefense)}),
                partyName: PartyNameFilter({PartyParam.reform, PartyParam.peoplePower}),
                proposerType: ProposerTypeFilter({BillProposerParam.lawmaker}),
                progressStatus: ProgressStatusFilter({ProgressStatusParam.committeeReview, ProgressStatusParam.promulgated})
            )
        )
    );
  });

  test("소관위원회 bill detail요청", () async {
    final response = await service.retrieveLegislationAccountBillPostDetail(billId: "PRC_L2K4I0H5P3O1N1O1M0U1T1T6S4R3N3");
  });

  test("legislation type profile 요청", () async {
    final response = await service.retrieveProfile(CommitteeLegislationType.of(CommitteeParam.legislationAndJudiciary));
  });

  test("legislation profile info 요청", () async {
    final response = await service.retrieveCommitteeAccounts();
  });

  test("legislation 구독 요청", () async {
    try {
      final response = await service.activateSubscription(CommitteeLegislationType.of(CommitteeParam.legislationAndJudiciary));
    } on ApiException catch (e) {
      if(e.code == "409") {
        print("이미 구독됨");
      } else {
        rethrow;
      }
    }
  });

  test("legislation 구독 취소 요청", () async {
    try {
      final response = await service.deactivateSubscription(CommitteeLegislationType.of(CommitteeParam.legislationAndJudiciary));
    } on DioException catch (e) {
      if(e.response?.statusCode == 409) {
        print("이미 구독취소됨");
      } else {
        rethrow;
      }
    }
  });
}