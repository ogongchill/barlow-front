import 'package:features/bill/domain/constant/bill_post_tag.dart';
import 'package:features/bill/domain/constant/committee.dart';
import 'package:features/bill/domain/entities/bill_thumbnail.dart';
import 'package:features/shared/domain/page.dart';

abstract interface class CommitteeBillPostRepository {

  Future<List<BillThumbnail>> retrieve({required Committee committee, Page? page, List<BillPostTag>? tags});
}
