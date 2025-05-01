import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/pre_announce/domain/repositories/sort_key.dart';
import 'package:front/features/shared/viewmodel/bill_thumbnail_tag_notifier.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';

class SortKeyNotifier extends StateNotifier<PreAnnounceBillPostSortKey> {

  SortKeyNotifier() : super(PreAnnounceBillPostSortKey.asc);

  void toAsc() {
    if(state.isDescending) {
      state = PreAnnounceBillPostSortKey.asc;
    }
  }

  void toDsc() {
    if(state.isAscending) {
      state = PreAnnounceBillPostSortKey.dsc;
    }
  }

  void reset() {
    state = PreAnnounceBillPostSortKey.asc;
  }
}

final preAnnounceSortKeyProvider = StateNotifierProvider.autoDispose<SortKeyNotifier, PreAnnounceBillPostSortKey> (
    (ref) => SortKeyNotifier()
);

final preAnnounceTagProvider = StateNotifierProvider.autoDispose<BillThumbnailTagNotifier, UnmodifiableSetView<BillPostTag>>(
      (ref) => BillThumbnailTagNotifier(),
);

