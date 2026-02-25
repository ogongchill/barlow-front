import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/repositories/term_repository.dart';
import 'package:features/signup/domain/usecases/fetch_active_terms_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeTermRepository implements SignupTermRepository {
  final List<TermAgreementItem> terms;
  final Exception? error;

  _FakeTermRepository({this.terms = const [], this.error});

  @override
  Future<List<TermAgreementItem>> fetchActiveTerms() async {
    if (error != null) throw error!;
    return terms;
  }
}

void main() {
  group('FetchActiveTermsUseCase', () {
    test('repository 에서 반환된 약관 목록을 그대로 반환한다', () async {
      final expectedTerms = [
        const TermAgreementItem(
          id: 1,
          title: '서비스 이용약관',
          linkUrl: 'https://example.com/terms',
          isRequired: true,
          isAgreed: false,
        ),
        const TermAgreementItem(
          id: 2,
          title: '개인정보 처리방침',
          linkUrl: 'https://example.com/privacy',
          isRequired: true,
          isAgreed: false,
        ),
      ];
      final useCase = FetchActiveTermsUseCase(_FakeTermRepository(terms: expectedTerms));

      final result = await useCase.execute();

      expect(result.length, 2);
      expect(result.first.id, 1);
      expect(result.first.isAgreed, false);
    });

    test('약관 목록이 비어 있으면 빈 목록을 반환한다', () async {
      final useCase = FetchActiveTermsUseCase(_FakeTermRepository());

      final result = await useCase.execute();

      expect(result, isEmpty);
    });

    test('repository 에서 예외가 발생하면 예외를 전파한다', () async {
      final useCase = FetchActiveTermsUseCase(
        _FakeTermRepository(error: Exception('네트워크 오류')),
      );

      expect(() => useCase.execute(), throwsException);
    });
  });
}
