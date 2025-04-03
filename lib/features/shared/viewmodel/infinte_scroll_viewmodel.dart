import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/page.dart';

class InfiniteScrollBillPostState {
  final AsyncValue<List<BillThumbnail>> fetchingBills;
  final List<BillThumbnail> previousBills;
  final List<BillPostTag> selectedTags;
  final Page currentPage;

  InfiniteScrollBillPostState({
    required this.fetchingBills,
    required this.previousBills,
    required this.selectedTags,
    required this.currentPage,
  });

  InfiniteScrollBillPostState copyWith({
    AsyncValue<List<BillThumbnail>>? fetchingBills,
    List<BillThumbnail>? previousBills,
    List<BillPostTag>? selectedTags,
    Page? currentPage,
  }) {
    return InfiniteScrollBillPostState(
      fetchingBills: fetchingBills ?? this.fetchingBills,
      previousBills: previousBills ?? this.previousBills,
      selectedTags: selectedTags ?? this.selectedTags,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  List<BillThumbnail> getFetchedBill() {
    return fetchingBills.when(
        data: (billThumbnails) => [...previousBills, ...billThumbnails],
        error: (error, stack) => previousBills,
        loading: () => previousBills
    );
  }
}

abstract class InfiniteScrollBillPostViewModel {

  void changeTags(List<BillPostTag> tags);
  Future<void> nextPage();
  void init();
  void reset();
}