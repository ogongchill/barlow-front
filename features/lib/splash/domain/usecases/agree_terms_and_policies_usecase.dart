import 'package:core/storage/shared-preferences/share_prefs_terms_agreement_repository.dart';
import 'package:core/utils/application_version_info.dart';
import 'package:injectable/injectable.dart';

@injectable
class AgreeTermsAndPoliciesUseCase {

  final TermsAgreementRepository _repository;
  final ApplicationVersionInfo _applicationVersionInfo;

  AgreeTermsAndPoliciesUseCase(this._repository, this._applicationVersionInfo);

  Future<void> execute() async {
    await _repository.saveAgreement(_applicationVersionInfo.version);
  }
}

@injectable
class CheckTermsAndPoliciesUseCase {

  final TermsAgreementRepository _repository;

  CheckTermsAndPoliciesUseCase(this._repository);

  Future<bool> execute() async {
    return await _repository.getAgreementVersion() != null;
  }
}