import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/committee/domain/repositories/committee_bill_post_repository.dart';
import 'package:front/features/committee/domain/usecases/committee_bill_post_usecases.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/bill_thumbnail.dart';
import 'package:front/features/shared/domain/committee.dart';

class CommitteeBillPostState {
  final AsyncValue<List<BillThumbnail>> fetchingBills;
  final List<BillThumbnail> previousBills;
  final List<BillPostTag> selectedTags;
  final Page currentPage;

  CommitteeBillPostState({
    required this.fetchingBills,
    required this.previousBills,
    required this.selectedTags,
    required this.currentPage,
  });

  CommitteeBillPostState copyWith({
    AsyncValue<List<BillThumbnail>>? fetchingBills,
    List<BillThumbnail>? previousBills,
    List<BillPostTag>? selectedTags,
    Page? currentPage,
  }) {
    return CommitteeBillPostState(
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

class CommitteeBillPostViewModel extends StateNotifier<CommitteeBillPostState> {

  final Committee _committee;

  CommitteeBillPostViewModel(Committee committee)
      : _committee = committee,
        super(CommitteeBillPostState(
          fetchingBills: const AsyncValue.loading(),
          previousBills: [],
          selectedTags: [],
          currentPage: Page()));

  void toggleTag(BillPostTag tag) {
    List<BillPostTag> updatedTags = List.from(state.selectedTags);
    if (updatedTags.contains(tag)) {
      updatedTags.remove(tag);
    } else {
      updatedTags.add(tag);
    }
    _updateStateTo(state.copyWith(
      selectedTags: updatedTags,
      currentPage: Page(),
      previousBills: [],
      fetchingBills: const AsyncValue.loading()
    ));
    _fetchBills();
  }

  /// ✅ 다음 페이지 요청 (이전 데이터 유지)
  Future<void> nextPage() async {
    CommitteeBillPostState stateToUpdate = state.copyWith();
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

  void init() {
    _fetchBills();
  }

  void reset() {
    _updateStateTo(state.copyWith(
      fetchingBills: const AsyncValue.loading(),
      previousBills: [],
      selectedTags: [],
      currentPage: Page(),
    ));
    _fetchBills();
  }

  // CommitteeBillPostState에 따라 fetching
  Future<void> _fetchBills() async {
    final useCase = getIt<FetchCommitteeBillPostThumbnailsUseCase>();
    AsyncValue<List<BillThumbnail>> fetchingThumbnails = await AsyncValue.guard(
      () => useCase.execute(
            committee: _committee,
            page: state.currentPage,
            tags: state.selectedTags)
    );
    _updateStateTo(state.copyWith(fetchingBills: fetchingThumbnails));
  }

  void _updateStateTo(CommitteeBillPostState stateToUpdate) {
    state = stateToUpdate;
  }

}

final committeeBillPostProvider = StateNotifierProvider.family.autoDispose<CommitteeBillPostViewModel, CommitteeBillPostState, Committee>(
      (ref, committee) => CommitteeBillPostViewModel(committee),
);
