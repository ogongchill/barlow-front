import 'package:flutter_test/flutter_test.dart';
import 'package:front/core/api/common/api_request_params.dart';
import 'package:front/core/api/common/legislation_type.dart';
import 'package:front/core/api/pre-announce/pre_announce_request_param.dart';
import 'package:front/core/api/pre-announce/pre_announce_router.dart';
import 'package:front/features/shared/domain/bill_proposer_type.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/domain/party.dart';

import '../core_api_test_config.dart';

void main() {
  PreAnnounceRouter router = PreAnnounceRouter(mockClient);
  test("pre-announce bill thumbnail요청", () async {
    final response = await router.retrievePreAnnouncementBillThumbnail(
      param: PreAnnounceParam.from(
        billPostFilterParam: BillPostFilterParam(
            legislationType: LegislationFilterTag({CommitteeLegislationType.of(Committee.legislationAndJudiciary)}),
            proposerType: ProposerTypeFilter({BillProposerType.lawmaker, BillProposerType.government}),
            partyName: PartyNameFilter({Party.peoplePower, Party.democratic})
        ),
        pagingParam: PagingParam(0, 10),
        preAnnounceSortKey: PreAnnounceSortKey.deadlineDesc
      )
    );
  });

  test("pre-announce bill detail 요청", () async {
    final response = await router.retrievePreAnnouncementBillDetail("PRC_L2T5R0S3R2Q5Y1W5V2U4U1D9B3A6Z5");
  });
}