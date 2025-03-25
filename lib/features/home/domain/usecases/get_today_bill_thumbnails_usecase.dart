import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/home/domain/repositories/today_bill_thumbnail_repository.dart';

class GetTodayBillThumbnailsUseCase {

  final TodayBillThumbnailRepository _repository;

  GetTodayBillThumbnailsUseCase(this._repository);

  Future<List<BillThumbnail>> fetch() {
    return _repository.retrieveTodayBillThumbnails();
  }
}