# Barlow Monorepo Rules

이 저장소는 Flutter 기반 mono repo이며, 모듈 책임을 엄격히 분리한다.

## 모듈 구성
- `app`: 앱 엔트리포인트 및 플랫폼 통합
- `core`: 공통 인프라/유틸/설정
- `design_system`: 전역 UI 스타일/디자인 자산
- `features`: 사용자 기능 단위 구현

## 의존성 규칙
- `app` -> `features`, `core`, `design_system`
- `features` -> `core`, `design_system`
- `design_system` -> (가능하면 독립, 필요 최소한만 `core`)
- `core` -> 가능한 한 독립

## 절대 금지
- `core`에서 `features` 참조 금지
- `design_system`에 비즈니스 로직 추가 금지
- feature 간 내부 구현 직접 참조 금지
    - 필요 시 `core` 또는 공통 모듈로 승격

## 작업 원칙
- 변경 시 해당 모듈의 책임 범위를 먼저 확인한다.
- 코드 추가 전 "이 코드가 어느 모듈 책임인지" 판단한다.
- 공통화는 성급하게 하지 말고, 2개 이상 feature에서 반복될 때 검토한다.

## 상태관리 / 아키텍처 원칙
- Feature 중심 구조를 우선한다.
- 상태관리(Riverpod)는 feature 내부에 둔다.
- 전역 설정/초기화는 `app` 또는 `core`에 둔다.

## Riverpod 컨벤션

### 네이밍
- Notifier 클래스: `<Feature>Notifier` (예: `BillListNotifier`, `SettingsNotifier`)
- Provider 변수: `<feature>Provider` (예: `billListProvider`, `settingsProvider`)
- State 클래스: `<Feature>State` (예: `BillListState`, `SettingsState`)
- AsyncNotifier 사용 시: 비동기 초기화가 필요한 경우에 한해 사용

### 상태 구조
- 상태는 `AsyncValue<T>`를 직접 반환하거나, 명시적 sealed/freezed State 클래스로 표현한다.
- loading / error / data 3가지 케이스를 항상 처리한다.
- UI에서 `when` / `maybeWhen` 사용 시 `orElse` 생략 금지.

### Provider 배치
- feature 전용 provider는 해당 feature 디렉토리 내 `provider/` 또는 `application/`에 둔다.
- 전역에서 사용하는 provider는 `core`에 두되, feature 로직을 포함하지 않는다.
- provider 파일 하나에 하나의 Notifier + provider 선언을 원칙으로 한다.

### 주의사항
- `ref.read`는 이벤트 핸들러(버튼 콜백 등) 내부에서만 사용한다.
- `ref.watch`는 build 메서드 또는 ConsumerWidget/HookConsumerWidget 내에서만 사용한다.
- provider 간 순환 의존 금지.

## 커밋/브랜치 컨벤션 참고
- Angular JS commit convention 사용
- 브랜치: `dev`, `main`, `release/*`, `hotfix`, `<topic>/issue/<number>`
