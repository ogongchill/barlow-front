import 'package:flutter_test/flutter_test.dart';
import 'package:front/core/api/common/api_request_params.dart';
import 'package:front/core/api/recent-bill/recent_bill_router.dart';
import 'package:front/features/shared/domain/bill_progress_status.dart';
import 'package:front/features/shared/domain/bill_proposer_type.dart';
import 'package:front/features/shared/domain/party.dart';

import '../core_api_test_config.dart';

void main() {
  RecentBillRouter router = RecentBillRouter(mockClient);
  test("GET: /api/v1/recent-bill", () async {
    final response = await router.retrieveRecentBillThumbnail(
      params: BillPostParams.from(
        billPostFilterParam: BillPostFilterParam(
          // legislationType: LegislationFilterTag({CommitteeLegislationType.of(Committee.legislationAndJudiciary)}),
          partyName: PartyNameFilter({Party.democratic, Party.peoplePower}),
          proposerType: ProposerTypeFilter({BillProposerType.lawmaker, BillProposerType.speaker}),
          progressStatus: ProgressStatusFilter({ProgressStatus.withdrawn})
        ),
        sortKeyParam: SortKeyParam(SortKey.createdAtAsc),
        pagingParam: PagingParam(0, 10)
      )
    );
  });

  test('api/v1/recent-bill/:billId', () async {
    final response = await router.retrieveRecentBillDetail("PRC_K2I5K0D3Q0S7I1J0Q0M1N3N4G7U7Z4");
  });
}