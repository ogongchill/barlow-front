import 'package:front/features/bill_info/domain/repositories/bill_repository.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';

import 'package:front/features/shared/domain/page.dart';

class FetchRecentBillThumbnailUseCase {

  final RecentBillRepository _repository;

  FetchRecentBillThumbnailUseCase({required RecentBillRepository repository})
   : _repository = repository;

  Future<List<BillThumbnail>> execute({required Page page, required List<BillPostTag> tags}) {
    return _repository.retrieve(page, tags);
  }
}