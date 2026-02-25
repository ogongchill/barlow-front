import 'package:core/api/api_router.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/repositories/term_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignupTermRepository)
class SignupTermRepositoryAdapter implements SignupTermRepository {

  final ApiRouter _router;

  SignupTermRepositoryAdapter(this._router);

  @override
  Future<List<TermAgreementItem>> fetchActiveTerms() async {
    final response = await _router.termRouter.retrieveCurrentActiveTerms();
    return response!.activeTerms
        .map(
          (term) => TermAgreementItem(
            id: term.id,
            title: term.title,
            linkUrl: term.linkUrl,
            isRequired: term.required,
            isAgreed: false,
          ),
        )
        .toList();
  }
}
