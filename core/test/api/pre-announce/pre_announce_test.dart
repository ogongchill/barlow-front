// import 'package:core/api/common/params/api_request_params.dart';
// import 'package:core/api/pre-announce/pre_announce_request_param.dart';
// import 'package:core/api/pre-announce/pre_announce_router.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import '../../test_config.dart';
//
// void main() {
//   PreAnnounceRouter router = PreAnnounceRouter(mockClient);
//   test("pre-announce bill thumbnail요청", () async {
//     final response = await router.retrievePreAnnouncementBillThumbnail(
//       param: PreAnnounceParam.from(
//         billPostFilterParam: BillPostFilterParam(
//             legislationType: LegislationFilterTag({CommitteeLegislationType.of(Committee.legislationAndJudiciary)}),
//             proposerType: ProposerTypeFilter({BillProposerType.lawmaker, BillProposerType.government}),
//             param: PartyNameFilter({Party.peoplePower, Party.democratic})
//         ),
//         value: PagingParam(0, 10),
//         preAnnounceSortKey: PreAnnounceSortKey.deadlineDesc
//       )
//     );
//   });
//
//   test("pre-announce bill detail 요청", () async {
//     final response = await router.retrievePreAnnouncementBillDetail("PRC_L2T5R0S3R2Q5Y1W5V2U4U1D9B3A6Z5");
//   });
// }