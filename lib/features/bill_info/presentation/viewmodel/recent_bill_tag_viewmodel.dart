import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';

class RecentBillPostTagNotifier extends StateNotifier<UnmodifiableSetView<BillPostTag>> {

  RecentBillPostTagNotifier() : super(UnmodifiableSetView({}));

  void toggleTag(BillPostTag toggleTarget) {
    final updatedTagSet = Set<BillPostTag>.from(state);
    if(updatedTagSet.contains(toggleTarget)) {
      updatedTagSet.remove(toggleTarget);
    } else {
      updatedTagSet.add(toggleTarget);
    }
    state = UnmodifiableSetView(updatedTagSet);
  }

  void resetTag() {
    state = UnmodifiableSetView({});
  }
}

final recentBillTagProvider = StateNotifierProvider.autoDispose<RecentBillPostTagNotifier, UnmodifiableSetView<BillPostTag>>(
      (ref) => RecentBillPostTagNotifier(),
);