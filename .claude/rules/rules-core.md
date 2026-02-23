# Module Rule: core

`core` 모듈은 앱 전반에서 재사용되는 공통 기반(인프라/유틸/설정) 모듈이다.

## 책임
- 네트워크 설정 및 클라이언트 구성
- 로컬 저장소 설정 (SharedPreferences 등)
- 공통 유틸리티, 헬퍼, 확장 함수
- 공통 예외/에러 모델, Result 타입
- 환경설정, 상수, 로깅, 공통 인터셉터

## 포함 가능
- HTTP client (예: Dio) 및 interceptors
- Token storage / secure storage wrapper
- Serializer, parser, formatter
- 공통 exception / failure / result classes
- 날짜/문자열/숫자 유틸
- 공통 infra adapter (단, feature 비종속)

## 포함 금지
- 특정 기능(로그인/설정/의안조회 등)에 종속된 비즈니스 규칙
- 특정 feature UI 상태 로직
- 화면/위젯 구현
- `features` 참조 (절대 금지)

## 의존성 규칙
- `core`는 최대한 독립적이어야 한다.
- `core` -> `features` 참조 금지
- `core` -> `design_system` 참조 지양 (필요 시 재검토)

## Claude Agent 작업 지침
- 새 코드를 `core`에 넣기 전에 "2개 이상 feature에서 재사용 가능한가?"를 확인한다.
- 재사용성이 낮고 도메인 맥락이 강하면 `features`로 둔다.
- `core` API는 가능한 한 단순하고 안정적으로 유지한다.
- feature 이름이 들어간 타입/함수명은 `core`에 두지 않는다.