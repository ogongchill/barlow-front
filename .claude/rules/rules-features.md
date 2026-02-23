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
- `application/` 또는 `provider/` : Riverpod 상태관리, notifier/provider
- `domain/` : entity, usecase, repository interface
- `data/` : repository 구현, datasource, dto/mapper

(프로젝트 상황에 따라 일부 폴더는 생략/통합 가능)

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