import 'package:core/api/api_router.dart';
import 'package:features/committee/domain/repositories/committee_bill_post_repository.dart';
import 'package:features/shared/domain/bill_post_tag.dart';
import 'package:features/shared/domain/bill_thumbnail.dart';
import 'package:features/shared/domain/committee.dart';
import 'package:features/shared/domain/page.dart';
import 'package:features/shared/infra/bill_post_tag_processor.dart';

class CommitteeBillPostRepositoryAdapter implements CommitteeBillPostRepository {

  final ApiRouter _apiRouter;

  CommitteeBillPostRepositoryAdapter(this._apiRouter);

  @override
  Future<List<BillThumbnail>> retrieve({required Committee committee, Page? page, List<BillPostTag>? tags}) async {
    final response = await _apiRouter.legislationAccountRouter
        .retrieveLegislationAccountBillPostThumbnails(
          committee: committee.param,
          requestParams: BillPostTagParamProcessor.composeFrom(page ?? Page(index: 0, size: 10), tags ?? [])
    );
    List<BillThumbnail> today = response!.today
        .map((thumbnail) => BillThumbnail(
          billId: thumbnail.billId,
          billName: thumbnail.billName,
          proposers: thumbnail.proposers,
          legislativeBody: thumbnail.legislationProcess))
        .toList();
    List<BillThumbnail> recent = response.recent
        .map((thumbnail) => BillThumbnail(
        billId: thumbnail.billId,
        billName: thumbnail.billName,
        proposers: thumbnail.proposers,
        legislativeBody: thumbnail.legislationProcess))
        .toList();
    return today + recent;
  }
}