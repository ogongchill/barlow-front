# Module Rule: design_system

`design_system` 모듈은 앱 전역의 UI 일관성을 위한 디자인 시스템 모듈이다.

## 책임
- 전역 테마 및 스타일 규칙 관리
- 디자인 토큰(색상, 타이포, spacing, radius 등) 관리
- 공통 UI 컴포넌트 제공
- 폰트/아이콘/이미지 등 디자인 자산 관리

## 포함 가능
- `ThemeData`, color schemes
- typography, spacing, elevation, radius tokens
- 공통 버튼/텍스트필드/칩/다이얼로그 스타일 컴포넌트
- 공통 아이콘 래퍼 / 에셋 경로 관리
- 재사용 가능한 프레젠테이션 전용 위젯

## 포함 금지
- API 호출
- 저장소 접근
- 비즈니스 로직
- feature 전용 상태/도메인 로직

## 의존성 규칙
- 가능하면 독립적으로 유지
- `core` 의존은 최소화 (예: 공통 formatter도 가능하면 분리 고려)
- `features` 참조 금지

## Claude Agent 작업 지침
- `design_system`에서는 "어떻게 보일지"만 다룬다.
- "무엇을 할지" (도메인/비즈니스)는 절대 넣지 않는다.
- 공통 위젯은 입력 파라미터 기반으로 동작하게 만들고, feature 상태를 직접 알지 못하게 한다.
- 특정 화면에서만 쓰이는 UI는 우선 feature 내부에 두고, 재사용될 때 승격한다.