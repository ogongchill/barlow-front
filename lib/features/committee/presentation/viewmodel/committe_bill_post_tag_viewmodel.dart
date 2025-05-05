import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/shared/domain/bill_post_tag.dart';
import 'package:front/features/shared/domain/committee.dart';

class CommitteeBillPostTagNotifier extends StateNotifier<UnmodifiableSetView<BillPostTag>> {

  final Committee _committee;

  CommitteeBillPostTagNotifier(this._committee) : super(UnmodifiableSetView({}));

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

final billPostTagProvider = StateNotifierProvider.autoDispose.family<CommitteeBillPostTagNotifier, UnmodifiableSetView<BillPostTag>, Committee>(
      (ref, committee) => CommitteeBillPostTagNotifier(committee),
);