import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:features/signup/presentation/viewmodel/kakao_signup_notifier.dart';
import 'package:features/signup/presentation/viewmodel/kakao_signup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// 테스트 전용 Notifier: UseCase 를 콜백으로 주입받아 kakao SDK 트랜지티브 의존 회피

class _TestableKakaoSignupNotifier extends KakaoSignupNotifier {
  final Future<String> Function() getIdToken;
  final Future<List<TermAgreementItem>> Function() fetchTerms;

  _TestableKakaoSignupNotifier({
    required this.getIdToken,
    required this.fetchTerms,
  });

  @override
  Future<void> onKakaoLoginButtonTapped() async {
    if (state is KakaoSignupLoading) return;

    state = const KakaoSignupLoading();

    try {
      final idToken = await getIdToken();
      final terms = await fetchTerms();
      state = KakaoSignupTermsReady(idToken: idToken, terms: terms);
    } catch (e) {
      state = KakaoSignupError(message: e.toString());
    }
  }
}

// 테스트 헬퍼

ProviderContainer _makeContainer({
  required Future<String> Function() getIdToken,
  required Future<List<TermAgreementItem>> Function() fetchTerms,
}) {
  return ProviderContainer(
    overrides: [
      kakaoSignupProvider.overrideWith(
        () => _TestableKakaoSignupNotifier(
          getIdToken: getIdToken,
          fetchTerms: fetchTerms,
        ),
      ),
    ],
  );
}

// 테스트 픽스처

const _testIdToken = 'kakao.oidc.id.token';

final _testTerms = [
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

// 테스트

void main() {
  group('KakaoSignupNotifier', () {
    test('초기 상태는 KakaoSignupIdle 이다', () {
      final container = _makeContainer(
        getIdToken: () async => _testIdToken,
        fetchTerms: () async => _testTerms,
      );
      addTearDown(container.dispose);

      expect(container.read(kakaoSignupProvider), isA<KakaoSignupIdle>());
    });

    test('onKakaoLoginButtonTapped 호출 시 KakaoSignupTermsReady 로 전이된다', () async {
      final container = _makeContainer(
        getIdToken: () async => _testIdToken,
        fetchTerms: () async => _testTerms,
      );
      addTearDown(container.dispose);

      await container
          .read(kakaoSignupProvider.notifier)
          .onKakaoLoginButtonTapped();

      final state = container.read(kakaoSignupProvider);
      expect(state, isA<KakaoSignupTermsReady>());

      final readyState = state as KakaoSignupTermsReady;
      expect(readyState.idToken, _testIdToken);
      expect(readyState.terms.length, 2);
      expect(readyState.terms.first.id, 1);
    });

    test('idToken 획득 실패 시 KakaoSignupError 로 전이된다', () async {
      final container = _makeContainer(
        getIdToken: () async => throw StateError('OIDC 스코프 없음'),
        fetchTerms: () async => _testTerms,
      );
      addTearDown(container.dispose);

      await container
          .read(kakaoSignupProvider.notifier)
          .onKakaoLoginButtonTapped();

      final state = container.read(kakaoSignupProvider);
      expect(state, isA<KakaoSignupError>());
      expect((state as KakaoSignupError).message, contains('OIDC 스코프 없음'));
    });

    test('약관 조회 실패 시 KakaoSignupError 로 전이된다', () async {
      final container = _makeContainer(
        getIdToken: () async => _testIdToken,
        fetchTerms: () async => throw Exception('네트워크 오류'),
      );
      addTearDown(container.dispose);

      await container
          .read(kakaoSignupProvider.notifier)
          .onKakaoLoginButtonTapped();

      final state = container.read(kakaoSignupProvider);
      expect(state, isA<KakaoSignupError>());
      expect((state as KakaoSignupError).message, contains('네트워크 오류'));
    });

    test('로딩 중 중복 탭은 무시된다', () async {
      var idTokenCallCount = 0;

      final container = _makeContainer(
        getIdToken: () async {
          idTokenCallCount++;
          await Future<void>.delayed(const Duration(milliseconds: 100));
          return _testIdToken;
        },
        fetchTerms: () async => _testTerms,
      );
      addTearDown(container.dispose);

      final firstTap = container
          .read(kakaoSignupProvider.notifier)
          .onKakaoLoginButtonTapped();
      // 첫 번째 탭 완료 전에 두 번째 탭 — 무시되어야 한다
      await container
          .read(kakaoSignupProvider.notifier)
          .onKakaoLoginButtonTapped();
      await firstTap;

      expect(idTokenCallCount, 1, reason: 'UseCase 는 정확히 1회만 호출되어야 한다');
    });

    test('resetToIdle 호출 시 KakaoSignupIdle 로 복귀한다', () async {
      final container = _makeContainer(
        getIdToken: () async => throw Exception('오류'),
        fetchTerms: () async => [],
      );
      addTearDown(container.dispose);

      await container
          .read(kakaoSignupProvider.notifier)
          .onKakaoLoginButtonTapped();
      expect(container.read(kakaoSignupProvider), isA<KakaoSignupError>());

      container.read(kakaoSignupProvider.notifier).resetToIdle();
      expect(container.read(kakaoSignupProvider), isA<KakaoSignupIdle>());
    });
  });
}