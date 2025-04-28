import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/committee.dart';
import 'package:front/features/shared/domain/page.dart';

abstract interface class CommitteeBillPostRepository {

  Future<List<BillThumbnail>> retrieve({required Committee committee, Page? page, List<BillPostTag>? tags});
}
