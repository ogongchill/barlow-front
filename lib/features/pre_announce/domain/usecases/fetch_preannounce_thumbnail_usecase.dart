import 'package:front/features/pre_announce/domain/entities/preannounce_bill_thumbnail.dart';
import 'package:front/features/pre_announce/domain/repositories/preannounce_bill_thumbnail_repository.dart';
import 'package:front/features/pre_announce/domain/repositories/sort_key.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/page.dart';

class FetchPreAnnounceThumbnailUseCase {

  final PreAnnounceBillThumbnailRepository _repository;

  FetchPreAnnounceThumbnailUseCase({required PreAnnounceBillThumbnailRepository repository})
    : _repository = repository;

  Future<List<PreAnnounceBillThumbnail>> execute({Page? page, List<BillPostTag>? tags, SortKey? sortKey}) {
    return _repository.retrieve(page: page, tags: tags, sortKey: sortKey);
  }
}