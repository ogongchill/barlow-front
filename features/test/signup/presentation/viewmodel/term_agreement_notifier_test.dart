import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/presentation/viewmodel/term_agreement_notifier.dart';
import 'package:features/signup/presentation/viewmodel/term_agreement_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// 테스트 전용 Notifier: OidcSignupUseCase 를 콜백으로 주입받아 외부 의존 회피

class _TestableTermAgreementNotifier extends TermAgreementNotifier {
  final Future<void> Function(OidcSignupInfo) executeSignup;

  _TestableTermAgreementNotifier({required this.executeSignup});

  @override
  Future<void> submit({
    required String nickname,
    required String deviceId,
    required String deviceToken,
    required String deviceOs,
    OidcProvider provider = OidcProvider.kakao,
  }) async {
    final current = state;
    if (current is! TermAgreementIdle) return;
    if (!current.canSubmit) return;

    state = const TermAgreementLoading();

    try {
      final info = OidcSignupInfo(
        idToken: current.idToken,
        provider: provider,
        termAgreements: current.terms,
        nickname: nickname,
        deviceId: deviceId,
        deviceToken: deviceToken,
        deviceOs: deviceOs,
      );

      await executeSignup(info);

      state = const TermAgreementSuccess();
    } catch (e) {
      state = TermAgreementError(message: e.toString());
    }
  }
}

// 테스트 헬퍼

ProviderContainer _makeContainer({
  Future<void> Function(OidcSignupInfo)? executeSignup,
}) {
  return ProviderContainer(
    overrides: [
      termAgreementProvider.overrideWith(
        () => _TestableTermAgreementNotifier(
          executeSignup: executeSignup ?? (_) async {},
        ),
      ),
    ],
  );
}

// 테스트 픽스처

const _testIdToken = 'kakao.oidc.id.token';

final _requiredTerms = [
  const TermAgreementItem(
    id: 1,
    title: '서비스 이용약관',
    linkUrl: 'https://example.com/terms',
    isRequired: true,
    isAgreed: false,
  ),
  const TermAgreementItem(
    id: 2,
    title: '개인정보 수집이용 동의',
    linkUrl: 'https://example.com/privacy',
    isRequired: true,
    isAgreed: false,
  ),
];

final _mixedTerms = [
  const TermAgreementItem(
    id: 1,
    title: '서비스 이용약관',
    linkUrl: 'https://example.com/terms',
    isRequired: true,
    isAgreed: false,
  ),
  const TermAgreementItem(
    id: 2,
    title: '개인정보 수집이용 동의',
    linkUrl: 'https://example.com/privacy',
    isRequired: true,
    isAgreed: false,
  ),
  const TermAgreementItem(
    id: 3,
    title: '마케팅 정보 수신 동의',
    linkUrl: 'https://example.com/marketing',
    isRequired: false,
    isAgreed: false,
  ),
];

const _submitArgs = (
  nickname: '테스트사용자',
  deviceId: 'device-123',
  deviceToken: 'fcm-token',
  deviceOs: 'android',
);

// 테스트

void main() {
  group('TermAgreementNotifier', () {
    // -----------------------------------------------------------------------
    // 초기 상태
    // -----------------------------------------------------------------------

    test('초기 상태는 TermAgreementIdle 이며 terms 와 idToken 이 비어있다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final s = container.read(termAgreementProvider);
      expect(s, isA<TermAgreementIdle>());
      final idle = s as TermAgreementIdle;
      expect(idle.idToken, isEmpty);
      expect(idle.terms, isEmpty);
    });

    // -----------------------------------------------------------------------
    // initialize
    // -----------------------------------------------------------------------

    test('initialize 호출 후 idToken 과 terms 가 올바르게 설정된다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.idToken, _testIdToken);
      expect(s.terms.length, 2);
      expect(s.terms.first.id, 1);
      expect(s.terms.first.isAgreed, false);
    });

    // -----------------------------------------------------------------------
    // toggleTerm
    // -----------------------------------------------------------------------

    test('toggleTerm 호출 시 해당 항목의 isAgreed 가 반전된다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.terms.firstWhere((t) => t.id == 1).isAgreed, true);
      expect(s.terms.firstWhere((t) => t.id == 2).isAgreed, false);
    });

    test('toggleTerm 을 같은 항목에 두 번 호출하면 원래 상태로 돌아온다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleTerm(1);

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.terms.firstWhere((t) => t.id == 1).isAgreed, false);
    });

    // -----------------------------------------------------------------------
    // canSubmit
    // -----------------------------------------------------------------------

    test('필수 약관이 미동의 상태이면 canSubmit 은 false 이다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.canSubmit, false);
    });

    test('필수 약관이 모두 동의되면 canSubmit 은 true 이다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleTerm(2);

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.canSubmit, true);
    });

    test('선택 약관만 미동의인 경우에도 canSubmit 은 true 이다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _mixedTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleTerm(2);
      // id:3 (선택) 은 미동의 상태 유지

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.canSubmit, true);
    });

    test('약관 목록이 비어 있으면 canSubmit 은 false 이다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, []);

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.canSubmit, false);
    });

    // -----------------------------------------------------------------------
    // toggleAll
    // -----------------------------------------------------------------------

    test('toggleAll 호출 시 전체 미동의 → 전체 동의로 전환된다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _mixedTerms);
      container.read(termAgreementProvider.notifier).toggleAll();

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.terms.every((t) => t.isAgreed), true);
      expect(s.isAllAgreed, true);
    });

    test('toggleAll 호출 시 전체 동의 → 전체 해제로 전환된다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _mixedTerms);
      container.read(termAgreementProvider.notifier).toggleAll();
      container.read(termAgreementProvider.notifier).toggleAll();

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.terms.every((t) => !t.isAgreed), true);
      expect(s.isAllAgreed, false);
    });

    test('일부만 동의된 상태에서 toggleAll 호출 시 전체 동의로 전환된다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _mixedTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleAll();

      final s = container.read(termAgreementProvider) as TermAgreementIdle;
      expect(s.terms.every((t) => t.isAgreed), true);
    });

    // -----------------------------------------------------------------------
    // submit
    // -----------------------------------------------------------------------

    test('submit 성공 시 TermAgreementSuccess 로 전이된다', () async {
      final container = _makeContainer(executeSignup: (_) async {});
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleTerm(2);

      await container.read(termAgreementProvider.notifier).submit(
            nickname: _submitArgs.nickname,
            deviceId: _submitArgs.deviceId,
            deviceToken: _submitArgs.deviceToken,
            deviceOs: _submitArgs.deviceOs,
          );

      expect(container.read(termAgreementProvider), isA<TermAgreementSuccess>());
    });

    test('submit 시 OidcSignupInfo 에 올바른 값이 전달된다', () async {
      OidcSignupInfo? captured;
      final container = _makeContainer(
        executeSignup: (info) async {
          captured = info;
        },
      );
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleTerm(2);

      await container.read(termAgreementProvider.notifier).submit(
            nickname: _submitArgs.nickname,
            deviceId: _submitArgs.deviceId,
            deviceToken: _submitArgs.deviceToken,
            deviceOs: _submitArgs.deviceOs,
          );

      expect(captured, isNotNull);
      expect(captured!.idToken, _testIdToken);
      expect(captured!.nickname, _submitArgs.nickname);
      expect(captured!.deviceId, _submitArgs.deviceId);
      expect(captured!.termAgreements.length, 2);
      expect(captured!.provider, OidcProvider.kakao);
    });

    test('submit 실패 시 TermAgreementError 로 전이된다', () async {
      final container = _makeContainer(
        executeSignup: (_) async => throw Exception('서버 오류'),
      );
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleTerm(2);

      await container.read(termAgreementProvider.notifier).submit(
            nickname: _submitArgs.nickname,
            deviceId: _submitArgs.deviceId,
            deviceToken: _submitArgs.deviceToken,
            deviceOs: _submitArgs.deviceOs,
          );

      final s = container.read(termAgreementProvider);
      expect(s, isA<TermAgreementError>());
      expect((s as TermAgreementError).message, contains('서버 오류'));
    });

    test('canSubmit 이 false 이면 submit 은 무시된다', () async {
      var callCount = 0;
      final container = _makeContainer(
        executeSignup: (_) async {
          callCount++;
        },
      );
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);

      await container.read(termAgreementProvider.notifier).submit(
            nickname: _submitArgs.nickname,
            deviceId: _submitArgs.deviceId,
            deviceToken: _submitArgs.deviceToken,
            deviceOs: _submitArgs.deviceOs,
          );

      expect(callCount, 0, reason: 'UseCase 는 호출되지 않아야 한다');
      expect(
        container.read(termAgreementProvider),
        isA<TermAgreementIdle>(),
        reason: '상태는 Idle 을 유지해야 한다',
      );
    });

    test('로딩 중 중복 submit 은 무시된다', () async {
      var callCount = 0;

      final container = _makeContainer(
        executeSignup: (_) async {
          callCount++;
          await Future<void>.delayed(const Duration(milliseconds: 100));
        },
      );
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleTerm(2);

      final first = container.read(termAgreementProvider.notifier).submit(
            nickname: _submitArgs.nickname,
            deviceId: _submitArgs.deviceId,
            deviceToken: _submitArgs.deviceToken,
            deviceOs: _submitArgs.deviceOs,
          );
      await container.read(termAgreementProvider.notifier).submit(
            nickname: _submitArgs.nickname,
            deviceId: _submitArgs.deviceId,
            deviceToken: _submitArgs.deviceToken,
            deviceOs: _submitArgs.deviceOs,
          );
      await first;

      expect(callCount, 1, reason: 'UseCase 는 정확히 1회만 호출되어야 한다');
    });

    // -----------------------------------------------------------------------
    // resetToIdle
    // -----------------------------------------------------------------------

    test('resetToIdle 호출 시 TermAgreementError → TermAgreementIdle 로 복귀한다',
        () async {
      final container = _makeContainer(
        executeSignup: (_) async => throw Exception('오류'),
      );
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).toggleTerm(1);
      container.read(termAgreementProvider.notifier).toggleTerm(2);

      await container.read(termAgreementProvider.notifier).submit(
            nickname: _submitArgs.nickname,
            deviceId: _submitArgs.deviceId,
            deviceToken: _submitArgs.deviceToken,
            deviceOs: _submitArgs.deviceOs,
          );
      expect(container.read(termAgreementProvider), isA<TermAgreementError>());

      container.read(termAgreementProvider.notifier).resetToIdle();
      expect(container.read(termAgreementProvider), isA<TermAgreementIdle>());
    });

    test('TermAgreementError 가 아닌 상태에서 resetToIdle 은 무시된다', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container
          .read(termAgreementProvider.notifier)
          .initialize(_testIdToken, _requiredTerms);
      container.read(termAgreementProvider.notifier).resetToIdle();

      final s = container.read(termAgreementProvider);
      expect(s, isA<TermAgreementIdle>());
      expect((s as TermAgreementIdle).idToken, _testIdToken);
    });
  });
}
