import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front/core/api/common/api_request_params.dart';
import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/core/api/legislation-account/legislation_account_router.dart';
import 'package:front/features/shared/domain/bill_progress_status.dart';
import 'package:front/features/shared/domain/bill_proposer_type.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/domain/party.dart';

import '../core_api_test_config.dart';

void main() {
  LegislationAccountRouter service = LegislationAccountRouter(mockClient);
  test('소관위원회 bill-post thumbnail요청', () async {
   final response = await service.retrieveLegislationAccountBillPostThumbnails(
     committee: Committee.landInfrastructureAndTransport,
     requestParams: BillPostParams.from(
       pagingParam: PagingParam(0, 10),
       sortKeyParam: SortKeyParam(SortKey.createdAtAsc),
       billPostFilterParam: BillPostFilterParam(
         partyName: PartyNameFilter({Party.reform, Party.peoplePower}),
         proposerType: ProposerTypeFilter({BillProposerType.lawmaker}),
         progressStatus: ProgressStatusFilter({ProgressStatus.committeeReview, ProgressStatus.promulgated})
       )
     )
   );
  });

  test("소관위원회 bill detail요청", () async {
    final response = await service.retrieveLegislationAccountBillPostDetail(billId: "PRC_L2K4I0H5P3O1N1O1M0U1T1T6S4R3N3");
  });

  test("legislation type profile 요청", () async {
    final response = await service.retrieveProfile(CommitteeLegislationType.of(Committee.legislationAndJudiciary));
  });

  test("legislation profile info 요청", () async {
    final response = await service.retrieveCommitteeAccounts();
  });

  test("legislation 구독 요청", () async {
    try {
      final response = await service.activateSubscription(CommitteeLegislationType.of(Committee.legislationAndJudiciary));
    } on DioException catch (e) {
      if(e.response?.statusCode == 409) {
        print("이미 구독됨");
      } else {
        rethrow;
      }
    }
  });

  test("legislation 구독 취소 요청", () async {
    try {
      final response = await service.deactivateSubscription(CommitteeLegislationType.of(Committee.legislationAndJudiciary));
    } on DioException catch (e) {
      if(e.response?.statusCode == 409) {
        print("이미 구독취소됨");
      } else {
        rethrow;
      }
    }
  });
}