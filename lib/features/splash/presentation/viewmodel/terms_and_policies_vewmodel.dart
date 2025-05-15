import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/dependency/service_locator.dart';
import 'package:front/features/splash/domain/usecases/agree_terms_and_policies_usecase.dart';

final termsAgreementViewModelProvider = StateNotifierProvider<TermsAgreementViewModel, AsyncValue<bool>>(
      (ref) => TermsAgreementViewModel(
    getIt<CheckTermsAndPoliciesUseCase>(),
    getIt<AgreeTermsAndPoliciesUseCase>(),
  ),
);

class TermsAgreementViewModel extends StateNotifier<AsyncValue<bool>> {
  final CheckTermsAndPoliciesUseCase _checkUseCase;
  final AgreeTermsAndPoliciesUseCase _agreeUseCase;

  TermsAgreementViewModel(this._checkUseCase, this._agreeUseCase) : super(const AsyncValue.loading()) {
    checkAgreementStatus();
  }

  Future<void> checkAgreementStatus() async {
    try {
      final result = await _checkUseCase.execute();
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> agree() async {
    try {
      await _agreeUseCase.execute();
      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
