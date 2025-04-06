import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/pre_announce/domain/repositories/sort_key.dart';
import 'package:front/features/shared/viewmodel/bill_thumbnail_tag_notifier.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';

class SortKeyNotifier extends StateNotifier<SortKey> {

  SortKeyNotifier() : super(SortKey.asc);

  void toAsc() {
    if(state.isDescending) {
      state = SortKey.asc;
    }
  }

  void toDsc() {
    if(state.isAscending) {
      state = SortKey.dsc;
    }
  }

  void reset() {
    state = SortKey.asc;
  }
}

final preAnnounceSortKeyProvider = StateNotifierProvider.autoDispose<SortKeyNotifier, SortKey> (
    (ref) => SortKeyNotifier()
);

final preAnnounceTagProvider = StateNotifierProvider.autoDispose<BillThumbnailTagNotifier, UnmodifiableSetView<BillPostTag>>(
      (ref) => BillThumbnailTagNotifier(),
);

