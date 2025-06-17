import 'package:features/bill/domain/constant/bill_post_tag.dart';

abstract class InfiniteScrollBillPostViewModel {

  void changeTags(List<BillPostTag> tags);
  Future<void> nextPage();
  void init();
  void reset();
}