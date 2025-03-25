import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/committee.dart';

abstract class CommitteeBillPostRepository {

  Future<List<BillThumbnail>> retrieve({required Committee committee, Page? page, List<BillPostTag>? tags});
}

class Page {

  final int _size;
  final int _index;

  Page({int? size, int? index})
    : _size = size ?? 10,
      _index = index ?? 1;

  Page next() {
    return Page(size : _size, index : _index + 1);
  }

  int get index => _index;

  int get size => _size;
}