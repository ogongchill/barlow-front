import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/repositories/term_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchActiveTermsUseCase {

  final SignupTermRepository _repository;

  FetchActiveTermsUseCase(this._repository);

  /// 현재 활성화된 약관 항목 목록을 반환한다.
  /// 각 항목의 isAgreed 초기값은 false 이다.
  Future<List<TermAgreementItem>> execute() {
    return _repository.fetchActiveTerms();
  }
}
