import 'package:features/bill_info/domain/entities/bill_detail.dart';
import 'package:features/shared/domain/bill_post_tag.dart';
import 'package:features/shared/domain/bill_thumbnail.dart';
import 'package:features/shared/domain/page.dart';

abstract interface class BillDetailRepository {

  Future<BillDetail> getBillDetail(String billId);
}

abstract interface class RecentBillRepository {

  Future<List<BillThumbnail>> retrieve(Page page, List<BillPostTag> tags);
}