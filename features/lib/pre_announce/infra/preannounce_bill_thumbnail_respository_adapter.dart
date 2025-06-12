import 'package:core/api/api_router.dart';
import 'package:features/pre_announce/domain/entities/preannounce_bill_thumbnail.dart';
import 'package:features/pre_announce/domain/repositories/preannounce_bill_thumbnail_repository.dart';
import 'package:features/pre_announce/domain/repositories/sort_key.dart';
import 'package:features/shared/domain/bill_post_tag.dart';
import 'package:features/shared/domain/page.dart';
import 'package:features/shared/infra/bill_post_tag_processor.dart';

class PreAnnounceBillThumbnailRepositoryAdapter implements PreAnnounceBillThumbnailRepository {

  final ApiRouter _apiRouter;

  PreAnnounceBillThumbnailRepositoryAdapter(this._apiRouter);

  @override
  Future<List<PreAnnounceBillThumbnail>> retrieve({Page? page, List<BillPostTag>? tags, PreAnnounceBillPostSortKey? sortKey}) async {
    final response = await _apiRouter.preAnnounceRouter.retrievePreAnnouncementBillThumbnail(
        param: BillPostTagParamProcessor.composePreAnnounceParamFrom(
          page ?? Page(size: 10, index: 0),
          tags ?? [],
          sortKey ?? PreAnnounceBillPostSortKey.asc)
    );
    return response!.thumbnails
        .map((thumbnail) => PreAnnounceBillThumbnail(
        billId: thumbnail.billId,
        billName: thumbnail.billName,
        proposers: thumbnail.proposers,
        dDay: thumbnail.dDay,
        legislativeBody: thumbnail.legislativeBody)
    ).toList();
  }
}