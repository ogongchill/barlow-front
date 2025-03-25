import 'package:front/features/shared/domain/bill_thumbnail.dart';

abstract class TodayBillThumbnailRepository {

  Future<List<BillThumbnail>> retrieveTodayBillThumbnails();
}