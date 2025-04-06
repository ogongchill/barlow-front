import 'package:front/features/pre_announce/domain/entities/preannounce_bill_thumbnail.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/page.dart';
import 'package:front/features/pre_announce/domain/repositories/sort_key.dart';

abstract class PreAnnounceBillThumbnailRepository {

  Future<List<PreAnnounceBillThumbnail>> retrieve({Page? page, List<BillPostTag>? tags, SortKey? sortKey});
}