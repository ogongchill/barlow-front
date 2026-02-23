# Module Rule: app

`app` 모듈은 애플리케이션 실행 및 플랫폼 통합 계층이다.

## 책임
- Flutter 앱 엔트리포인트 제공 (`main.dart`, 환경별 main)
- 플랫폼(Android/iOS) 네이티브 설정 관리
- 앱 부트스트랩 (초기화, 라우팅 시작점, DI 시작)
- 런타임 환경(dev/main/release/hotfix) 분기 처리

## 포함 가능
- `main.dart`, `main_dev.dart`, `main_prod.dart`
- 앱 초기화 코드 (binding/init)
- 전역 라우터 시작점
- 플랫폼 채널 연결 코드 (필요 시)
- Firebase/Crashlytics/Sentry 등 앱 시작 초기화

## 포함 금지
- 특정 feature의 비즈니스 로직
- feature 전용 상태관리 로직
- 공통 유틸 구현 (`core`로 이동)
- UI 디자인 토큰/컴포넌트 정의 (`design_system`로 이동)

## 의존성 규칙
- 참조 가능: `features`, `core`, `design_system`
- 하위 모듈의 내부 구현 상세를 직접 조작하지 말고 공개 API를 사용한다.

## Claude Agent 작업 지침
- `app`에서 로직을 추가할 때는 “초기화/조립 책임”인지 먼저 확인한다.
- 화면 기능 구현이 필요하면 `features`에 생성하고 `app`에서는 라우팅/연결만 한다.
- 환경별 분기(dev/prod)는 엔트리포인트 또는 config 레이어에서만 관리한다.