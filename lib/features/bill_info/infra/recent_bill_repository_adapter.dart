import 'package:front/core/api/api_router.dart';
import 'package:front/core/api/common/common_responses.dart';
import 'package:front/features/bill_info/domain/entities/bill_detail.dart';
import 'package:front/features/bill_info/domain/repositories/bill_repository.dart';
import 'package:front/features/shared/domain/bil_detail.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/page.dart';
import 'package:front/features/shared/domain/party.dart';
import 'package:front/features/shared/infra/bill_post_tag_processor.dart';

class BillDetailRepositoryAdapter implements BillDetailRepository {

  final ApiRouter _router;

  BillDetailRepositoryAdapter(this._router);

  @override
  Future<BillDetail> getBillDetail(String billId) async {
    final response = await _router.recentBillRouter.retrieveRecentBillDetail(billId);
    final detail = response!;
    return BillDetail(
        title: detail.title,
        proposerSummary: detail.proposerSummary,
        proposerType: detail.proposerType,
        legislativeBody: detail.legislativeBody,
        createdAt: detail.createdAt,
        detail: detail.detail ?? "내용이 없습니다",
        summarySection: BillAiSummary(title: detail.summarySection.summaryTitle, detail: detail.summarySection.summaryDetail ?? ""),
        proposerSection: toBillProposerSection(detail.proposerSection)
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

class RecentBillRepositoryAdapter implements RecentBillRepository{

  final ApiRouter _router;

  RecentBillRepositoryAdapter(this._router);

  @override
  Future<List<BillThumbnail>> retrieve(Page page, List<BillPostTag> tags) async {
    final response = await _router.recentBillRouter.retrieveRecentBillThumbnail(
      params: BillPostTagProcessor.composeFrom(page, tags)
    );
    List<BillThumbnail> todayThumbnail = response!.today
        .map((thumbnail) => BillThumbnail(billId: thumbnail.billId, billName: thumbnail.billName, proposers: thumbnail.proposers))
        .toList();
    List<BillThumbnail> recentThumbnail = response.recent
        .map((thumbnail) => BillThumbnail(billId: thumbnail.billId, billName: thumbnail.billName, proposers: thumbnail.proposers))
        .toList();
    return todayThumbnail + recentThumbnail;
  }
}
