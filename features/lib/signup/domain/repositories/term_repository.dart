import 'package:features/signup/domain/entities/oidc_signup_info.dart';

abstract interface class SignupTermRepository {

  /// 현재 활성화된 약관 항목 목록을 조회한다.
  Future<List<TermAgreementItem>> fetchActiveTerms();
}
