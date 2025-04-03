import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/bill_info/domain/usecases/fetch_recent_bill_thumbail_usecase.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/page.dart';
import 'package:front/features/shared/viewmodel/infinte_scroll_viewmodel.dart';

// class RecentBillPostState {
//   final AsyncValue<List<BillThumbnail>> fetchingBills;
//   final List<BillThumbnail> previousBills;
//   final List<BillPostTag> selectedTags;
//   final Page currentPage;
//
//   RecentBillPostState({
//     required this.fetchingBills,
//     required this.previousBills,
//     required this.selectedTags,
//     required this.currentPage,
//   });
//
//   RecentBillPostState copyWith({
//     AsyncValue<List<BillThumbnail>>? fetchingBills,
//     List<BillThumbnail>? previousBills,
//     List<BillPostTag>? selectedTags,
//     Page? currentPage,
//   }) {
//     return RecentBillPostState(
//       fetchingBills: fetchingBills ?? this.fetchingBills,
//       previousBills: previousBills ?? this.previousBills,
//       selectedTags: selectedTags ?? this.selectedTags,
//       currentPage: currentPage ?? this.currentPage,
//     );
//   }
//
//   List<BillThumbnail> getFetchedBill() {
//     return fetchingBills.when(
//         data: (billThumbnails) => [...previousBills, ...billThumbnails],
//         error: (error, stack) => previousBills,
//         loading: () => previousBills
//     );
//   }
// }

class RecentBillPostViewModel extends StateNotifier<InfiniteScrollBillPostState> implements InfiniteScrollBillPostViewModel {

  RecentBillPostViewModel()
    : super(InfiniteScrollBillPostState(
      fetchingBills: const AsyncValue.loading(),
      previousBills: [],
      selectedTags: [],
      currentPage: Page()));

  @override
  void changeTags(List<BillPostTag> tags) {
    _updateStateTo(state.copyWith(
        selectedTags: tags,
        currentPage: Page(),
        previousBills: [],
        fetchingBills: const AsyncValue.loading()
    ));
    _fetchBills();
  }

  @override
  Future<void> nextPage() async {
    InfiniteScrollBillPostState stateToUpdate = state.copyWith();
    state.fetchingBills.when(
        data: (thumbnails) {
          stateToUpdate = state.copyWith(
              fetchingBills: const AsyncValue.loading(),
              currentPage: state.currentPage.next(),
              previousBills: [...state.previousBills, ...thumbnails]
          );
        },
        error: (err, stack) => {},
        loading: () => {}
    );
    _updateStateTo(stateToUpdate);
    _fetchBills();
  }

  @override
  void init() {
    _fetchBills();
  }

  @override
  void reset() {
    _updateStateTo(state.copyWith(
      fetchingBills: const AsyncValue.loading(),
      previousBills: [],
      selectedTags: [],
      currentPage: Page(),
    ));
    _fetchBills();
  }

  Future<void> _fetchBills() async {
    final useCase = getIt<FetchRecentBillThumbnailUseCase>();
    AsyncValue<List<BillThumbnail>> fetchingThumbnails = await AsyncValue.guard(
            () => useCase.execute(
            page: state.currentPage,
            tags: state.selectedTags)
    );
    _updateStateTo(state.copyWith(fetchingBills: fetchingThumbnails));
  }

  void _updateStateTo(InfiniteScrollBillPostState stateToUpdate) {
    state = stateToUpdate;
  }
}

final recentBillProvider = StateNotifierProvider.autoDispose<RecentBillPostViewModel, InfiniteScrollBillPostState>(
      (ref) => RecentBillPostViewModel(),
);