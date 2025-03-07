import 'package:front/features/home/domain/entities/today_bill_thumbnail.dart';

abstract class TodayBillThumbnailRepository {

  Future<List<TodayBillThumbnail>> retrieveTodayBillThumbnails();
}