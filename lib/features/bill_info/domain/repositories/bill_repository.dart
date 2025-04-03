import 'package:front/features/bill_info/domain/entities/bill_detail.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/page.dart';

abstract class BillDetailRepository {

  Future<BillDetail> getBillDetail(String billId);
}

abstract class RecentBillRepository {

  Future<List<BillThumbnail>> retrieve(Page page, List<BillPostTag> tags);
}