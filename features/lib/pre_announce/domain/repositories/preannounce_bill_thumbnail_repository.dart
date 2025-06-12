import 'package:features/pre_announce/domain/entities/preannounce_bill_thumbnail.dart';
import 'package:features/pre_announce/domain/repositories/sort_key.dart';
import 'package:features/shared/domain/bill_post_tag.dart';
import 'package:features/shared/domain/page.dart';

abstract interface class PreAnnounceBillThumbnailRepository {

  Future<List<PreAnnounceBillThumbnail>> retrieve({Page? page, List<BillPostTag>? tags, PreAnnounceBillPostSortKey? sortKey});
}