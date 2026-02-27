# Module Rule: features

`features` 모듈은 사용자에게 제공되는 기능 단위의 구현 영역이다.

## 책임
- 사용자 기능 중심으로 UI/상태/비즈니스 로직 구성
- feature 단위 응집도 유지
- 기능별 라우트/화면/상태관리/도메인 로직 관리

## 예시 feature
- 로그인 / 회원가입
- 설정
- 의안 조회
- 즐겨찾기
- 사용자 프로필

## 권장 구조 (예시)
각 feature는 아래 구조를 따르는 것을 권장한다.

- `presentation/` : 화면, 위젯
  - `screen/`    : 라우터에 직접 연결되는 최상위 화면 단위 (ConsumerWidget/ConsumerStatefulWidget)
  - `view/`      : viewmodel과 결합된 단위. screen이 여러 view의 조합이 될 수 있음
  - `widget/`    : 재사용 가능한 StatelessWidget. viewmodel 의존 없이 파라미터만으로 동작
  - `viewmodel/` : Riverpod notifier, state, 보조 타입(sealed option 등) 정의
  - `util/`      : dialog, formatter 등 presentation 전용 유틸
- `domain/`      : entity, usecase, repository interface
- `data/`        : repository 구현, datasource, dto/mapper

(프로젝트 상황에 따라 일부 폴더는 생략/통합 가능)

## presentation 레이어 세부 규칙

### screen
- 라우터(`application_router.dart`)에 직접 등록되는 화면만 `screen/`에 위치한다.
- `Scaffold` 조립, `ref.listen`, 네비게이션 호출을 담당한다.
- 인라인 private 클래스는 최소화하고, 재사용 가능한 부분은 `view/` 또는 `widget/`으로 분리한다.

### view
- viewmodel(provider)에 직접 의존하는 ConsumerWidget 단위이다.
- screen이 단일 화면 단위로 충분히 간결하면 view 분리를 강제하지 않는다.
- 여러 screen에서 재사용되거나 viewmodel 결합 로직이 복잡해질 때 분리를 검토한다.

### widget
- `StatelessWidget`이어야 한다. viewmodel을 직접 알아서는 안 된다.
- 파라미터(callback 포함)만으로 동작해야 하며, 외부에서 상태를 주입받는다.
- screen/view 내에 인라인으로 정의된 private 클래스가 아래 조건을 만족하면 분리한다:
  - viewmodel 의존 없음
  - 50줄 이상이거나, 다른 screen에서 재사용 가능성이 있음

### viewmodel
- Notifier 클래스, State sealed class, provider 선언을 둔다.
- UI 전용 분기 타입(sealed LoginOption 등)도 viewmodel에 배치한다.
  (위젯이 아닌 타입 정의는 widget/에 두지 않는다)
- 파일 하나에 Notifier 1개 + provider 1개를 원칙으로 한다.

## 포함 가능
- feature UI
- feature 상태관리 (Riverpod)
- feature usecase
- feature repository interface + 구현
- feature 라우트 구성

## 포함 금지
- 전역 공통 유틸 (`core`로 이동)
- 전역 디자인 토큰/테마 (`design_system`로 이동)
- 플랫폼 네이티브 설정 (`app`으로 이동)

## 의존성 규칙
- `features` -> `core`, `design_system` 가능
- feature A -> feature B 직접 참조 지양
    - 필요한 공통 요소는 `core` 또는 별도 공통 모듈로 이동

## Claude Agent 작업 지침
- 새 기능은 반드시 feature 단위로 생성한다.
- 상태관리(Riverpod)는 해당 feature 내부에 둔다.
- feature 내부 타입 이름은 기능 맥락이 드러나게 작성한다.
    - 예: `LoginState`, `FetchBillsUseCase`, `SettingsNotifier`
- 공통화가 필요해 보이면 즉시 `core`로 이동하지 말고 반복 사용 여부를 확인한다.
- presentation 파일 배치 시 아래 질문으로 위치를 결정한다:
    1. 라우터에 직접 연결되는가? → `screen/`
    2. provider를 watch/listen/read 하는가? → `view/` (또는 screen이 충분히 단순하면 screen에 유지)
    3. 파라미터만으로 동작하고 StatelessWidget인가? → `widget/`
    4. 타입 정의(sealed class, enum 등)인가? → `viewmodel/`
- screen 이름은 실제 화면 맥락을 반영한다. 특정 구현 방식(ex. Kakao)을 이름에 포함하지 않는다.
    - ❌ `KakaoSignupTermsScreen` → ✅ `SignupTermsScreen`