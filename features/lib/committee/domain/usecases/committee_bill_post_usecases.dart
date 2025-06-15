import 'package:features/committee/domain/repositories/committee_bill_post_repository.dart';
import 'package:features/shared/domain/bill_post_tag.dart';
import 'package:features/shared/domain/bill_thumbnail.dart';
import 'package:features/shared/domain/committee.dart';
import 'package:features/shared/domain/page.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchCommitteeBillPostThumbnailsUseCase {

  final CommitteeBillPostRepository _repository;

  FetchCommitteeBillPostThumbnailsUseCase({required CommitteeBillPostRepository repository})
    : _repository = repository;

  Future<List<BillThumbnail>> execute({required Committee committee, Page? page, List<BillPostTag>? tags}) {
    return _repository.retrieve(committee: committee, page: page, tags: tags);
  }
}