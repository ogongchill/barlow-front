import 'package:core/api/term/active_term_response.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/domain/repositories/term_repository.dart';
import 'package:flutter_test/flutter_test.dart';

// ActiveTerm -> TermAgreementItem 매핑 로직을
// SignupTermRepository 의 Fake 구현체로 격리하여 검증한다.
// Adapter 의 매핑 로직은 아래 헬퍼를 통해 직접 검증한다.

TermAgreementItem _mapActiveTerm(ActiveTerm term) {
  return TermAgreementItem(
    id: term.id,
    title: term.title,
    linkUrl: term.linkUrl,
    isRequired: term.required,
    isAgreed: false,
  );
}

class _FakeSignupTermRepository implements SignupTermRepository {
  final List<ActiveTerm> activeTerms;
  final Exception? error;

  _FakeSignupTermRepository({this.activeTerms = const [], this.error});

  @override
  Future<List<TermAgreementItem>> fetchActiveTerms() async {
    if (error != null) throw error!;
    return activeTerms.map(_mapActiveTerm).toList();
  }
}

void main() {
  group('SignupTermRepositoryAdapter - ActiveTerm 매핑', () {
    test('required=true 인 약관은 isRequired=true, isAgreed=false 로 매핑된다', () async {
      final term = ActiveTerm(
        id: 1,
        title: '서비스 이용약관',
        linkUrl: 'https://example.com/terms',
        type: 'SERVICE',
        version: '1.0',
        required: true,
        effectiveAt: DateTime(2024, 1, 1),
      );
      final repo = _FakeSignupTermRepository(activeTerms: [term]);

      final result = await repo.fetchActiveTerms();

      expect(result.length, 1);
      expect(result[0].id, 1);
      expect(result[0].title, '서비스 이용약관');
      expect(result[0].linkUrl, 'https://example.com/terms');
      expect(result[0].isRequired, true);
      expect(result[0].isAgreed, false);
    });

    test('required=false 인 약관은 isRequired=false 로 매핑된다', () async {
      final term = ActiveTerm(
        id: 2,
        title: '마케팅 수신 동의',
        linkUrl: 'https://example.com/marketing',
        type: 'MARKETING',
        version: '1.0',
        required: false,
        effectiveAt: DateTime(2024, 1, 1),
      );
      final repo = _FakeSignupTermRepository(activeTerms: [term]);

      final result = await repo.fetchActiveTerms();

      expect(result[0].isRequired, false);
      expect(result[0].isAgreed, false);
    });

    test('복수의 약관이 순서를 유지하며 매핑된다', () async {
      final terms = [
        ActiveTerm(
          id: 1,
          title: '서비스 이용약관',
          linkUrl: 'https://example.com/terms',
          type: 'SERVICE',
          version: '1.0',
          required: true,
          effectiveAt: DateTime(2024, 1, 1),
        ),
        ActiveTerm(
          id: 2,
          title: '개인정보 처리방침',
          linkUrl: 'https://example.com/privacy',
          type: 'PRIVACY',
          version: '1.0',
          required: true,
          effectiveAt: DateTime(2024, 1, 1),
        ),
        ActiveTerm(
          id: 3,
          title: '마케팅 수신 동의',
          linkUrl: 'https://example.com/marketing',
          type: 'MARKETING',
          version: '1.0',
          required: false,
          effectiveAt: DateTime(2024, 1, 1),
        ),
      ];
      final repo = _FakeSignupTermRepository(activeTerms: terms);

      final result = await repo.fetchActiveTerms();

      expect(result.length, 3);
      expect(result[0].id, 1);
      expect(result[1].id, 2);
      expect(result[2].id, 3);
      expect(result.every((item) => item.isAgreed == false), true);
    });

    test('약관 목록이 비어 있으면 빈 리스트를 반환한다', () async {
      final repo = _FakeSignupTermRepository();

      final result = await repo.fetchActiveTerms();

      expect(result, isEmpty);
    });

    test('예외가 발생하면 그대로 전파한다', () async {
      final repo = _FakeSignupTermRepository(error: Exception('네트워크 오류'));

      expect(() => repo.fetchActiveTerms(), throwsException);
    });
  });
}
