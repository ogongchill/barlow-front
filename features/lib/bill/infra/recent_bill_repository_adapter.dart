import 'package:core/api/common/common_responses.dart';
import 'package:core/api/api_router.dart';
import 'package:features/bill/domain/constant/bill_post_tag.dart';
import 'package:features/bill/domain/entities/bill_detail.dart';
import 'package:features/bill/domain/entities/bill_thumbnail.dart';
import 'package:features/bill/domain/repositories/bill_repository.dart';
import 'package:features/bill/domain/entities/bill_detail_sections.dart';
import 'package:features/shared/domain/page.dart';
import 'package:features/bill/domain/constant/party.dart';
import 'package:features/bill/infra/bill_post_tag_processor.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BillDetailRepository)
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

@LazySingleton(as: RecentBillRepository)
class RecentBillRepositoryAdapter implements RecentBillRepository{

  final ApiRouter _router;

  RecentBillRepositoryAdapter(this._router);

  @override
  Future<List<BillThumbnail>> retrieve(Page page, List<BillPostTag> tags) async {
    final response = await _router.recentBillRouter.retrieveRecentBillThumbnail(
      params: BillPostTagParamProcessor.composeFrom(page, tags)
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
