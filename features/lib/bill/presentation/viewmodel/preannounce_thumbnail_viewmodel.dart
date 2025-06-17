import 'package:core/dependency/dependency_container.dart';
import 'package:features/bill/domain/constant/bill_post_tag.dart';
import 'package:features/bill/domain/entities/preannounce_bill_thumbnail.dart';
import 'package:features/bill/domain/repositories/sort_key.dart';
import 'package:features/bill/domain/usecases/fetch_preannounce_thumbnail_usecase.dart';
import 'package:features/bill/presentation/viewmodel/infinite_scroll_state.dart';
import 'package:features/shared/domain/page.dart';
import 'package:features/bill/presentation/viewmodel/infinte_scroll_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreAnnounceThumbnailViewModel extends StateNotifier<InfiniteScrollBillPostState<PreAnnounceBillThumbnail>> implements InfiniteScrollBillPostViewModel {

  PreAnnounceThumbnailViewModel()
      : super(InfiniteScrollBillPostState(
      fetchingBills: const AsyncValue.loading(),
      previousBills: [],
      selectedTags: [],
      currentPage: Page(),
      sortKey: PreAnnounceBillPostSortKey.asc));

  @override
  void changeTags(List<BillPostTag> tags) {
    _updateStateTo(state.copyWith(
        selectedTags: tags,
        currentPage: Page(),
        previousBills: [],
        fetchingBills: const AsyncValue.loading(),
    ));
    _fetch();
  }

  @override
  Future<void> nextPage() async {
    InfiniteScrollBillPostState<PreAnnounceBillThumbnail> stateToUpdate = state.copyWith();
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
    _fetch();
  }

  @override
  void init() {
    _fetch();
  }

  @override
  void reset() {
    _updateStateTo(state.copyWith(
      fetchingBills: const AsyncValue.loading(),
      previousBills: [],
      selectedTags: [],
      currentPage: Page(),
    ));
    _fetch();
  }

  Future<void> changeSortKey(PreAnnounceBillPostSortKey sortKey) async {
    _updateStateTo(state.copyWith(
        fetchingBills: const AsyncValue.loading(),
        previousBills: [],
        currentPage: Page(),
        sortKey: sortKey
    ));
    _fetch();
  }

  Future<void> _fetch() async {
    final useCase = dependencyContainer<FetchPreAnnounceThumbnailUseCase>();
    AsyncValue<List<PreAnnounceBillThumbnail>> fetchingThumbnails = await AsyncValue.guard(
            () => useCase.execute(
            page: state.currentPage,
            tags: state.selectedTags,
            sortKey: state.sortKey)
    );
    _updateStateTo(state.copyWith(fetchingBills: fetchingThumbnails));
  }

  void _updateStateTo(InfiniteScrollBillPostState<PreAnnounceBillThumbnail> stateToUpdate) {
    state = stateToUpdate;
  }
}

final preAnnounceThumbnailProvider = StateNotifierProvider.autoDispose<PreAnnounceThumbnailViewModel, InfiniteScrollBillPostState<PreAnnounceBillThumbnail>>(
      (ref) => PreAnnounceThumbnailViewModel(),
);