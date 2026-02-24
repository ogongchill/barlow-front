import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillAiSummaryState {
  final bool isExpanded;

  BillAiSummaryState({
    required this.isExpanded,
  });

  BillAiSummaryState copyWith({
    bool? isExpanded,
  }) {
    return BillAiSummaryState(
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class BillAiSummaryViewModel extends StateNotifier<BillAiSummaryState> {
  BillAiSummaryViewModel() : super(BillAiSummaryState(isExpanded: false));

  void toggleExpansion() {
    state = state.copyWith(isExpanded: !state.isExpanded);
  }
}

final billAiSummaryViewModelProvider = StateNotifierProvider.family<BillAiSummaryViewModel, BillAiSummaryState, String>(
  (ref, billId) => BillAiSummaryViewModel(),
);