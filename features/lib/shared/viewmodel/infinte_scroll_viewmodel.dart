import 'package:features/shared/domain/bill_post_tag.dart';
import 'package:features/shared/domain/bill_thumbnail.dart';
import 'package:features/shared/domain/page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfiniteScrollBillPostState<T extends BillThumbnail> {
  final AsyncValue<List<T>> fetchingBills;
  final List<T> previousBills;
  final List<BillPostTag> selectedTags;
  final dynamic sortKey;
  final Page currentPage;

  InfiniteScrollBillPostState({
    required this.fetchingBills,
    required this.previousBills,
    required this.selectedTags,
    required this.currentPage,
    this.sortKey
  });

  InfiniteScrollBillPostState<T> copyWith({
    AsyncValue<List<T>>? fetchingBills,
    List<T>? previousBills,
    List<BillPostTag>? selectedTags,
    Page? currentPage,
    dynamic sortKey,
  }) {
    return InfiniteScrollBillPostState<T>(
      fetchingBills: fetchingBills ?? this.fetchingBills,
      previousBills: previousBills ?? this.previousBills,
      selectedTags: selectedTags ?? this.selectedTags,
      currentPage: currentPage ?? this.currentPage,
      sortKey: sortKey ?? this.sortKey
    );
  }

  List<T> getFetchedBill() {
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