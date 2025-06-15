import 'package:core/api/api_router.dart';
import 'package:core/api/common/common_responses.dart';
import 'package:features/bill_info/domain/entities/bill_detail.dart';
import 'package:features/pre_announce/domain/entities/preannounce_bill_detail.dart';
import 'package:features/pre_announce/domain/repositories/preannounce_bill_detail_respository.dart';
import 'package:features/shared/domain/bil_detail.dart';
import 'package:features/shared/domain/party.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PreAnnounceBillDetailRepository)
class PreAnnounceBillDetailRepositoryAdapter implements PreAnnounceBillDetailRepository{

  final ApiRouter _apiRouter;

  PreAnnounceBillDetailRepositoryAdapter(this._apiRouter);

  @override
  Future<PreAnnounceBillDetail> retrieve({required String billId}) async {
    final response = await _apiRouter.preAnnounceRouter.retrievePreAnnouncementBillDetail(billId);
    return PreAnnounceBillDetail(
        title: response!.title,
        legislativeBody: response.legislativeBody,
        detail: response.detail,
        proposerSummary: response.proposerSummary,
        preAnnouncementSection: PreAnnouncementSection(
            deadline: response.preAnnouncementSection.deadline,
            dDAy: response.preAnnouncementSection.dDay,
            linkUrl: response.preAnnouncementSection.linkUrl
        ),
        proposerSection: toBillProposerSection(response.proposerSection),
        summarySection: BillAiSummary(title: response.summarySection.summaryTitle, detail: response.summarySection.summaryDetail ?? "")
    );
  }

  BillProposerSection? toBillProposerSection(ProposerSection? proposerSection) {
    if(proposerSection!.proposerPartyRate.isEmpty || proposerSection.proposerResponses.isEmpty) {
      return null;
    }
    Map<Party, int> partyRate = {};
    proposerSection.proposerPartyRate.forEach((key, value) {
      final party = Party.findByName(key);
      partyRate[party] = value;
    });

    return BillProposerSection(
        billProposerRate: BillProposerRate(proposerRate: partyRate),
        billProposers: proposerSection.proposerResponses
            .map((proposer) => BillProposer(
            name: proposer.name,
            profileImage: proposer.profileImage,
            partyName: proposer.partyName)
        ).toList()
    );
  }
}