# Barlow 프로젝트

이 저장소는 Barlow 어플리케이션을 위한 저장소입니다.

### 기술 스택 및 특징 ###
- Flutter 기반
- 크로스 플랫폼 지원을 목적으로 개발됨
- Git Actions를 통한 CI/CD 지원
- mono repo 구성

### 현재 상태 ###
- Android 빌드 가능
- iOS 및 기타 플랫폼은 준비 중

## 프로젝트 구조 ##
barlow app 프로젝트는 다음과 같은 mono repo 형식으로 구성되어있습니다.
```
🗀 app
🗀 core
🗀 design_system
🗀 features

```
### 🗀 app
- 크로스 플랫폼 구성을 위한 각 네이티브 코드가 위치합니다.
- flutter 앱의 엔트리 포인트를 포함합니다.

### 🗀 core
- 어플리케이션 내부에서 재사용 가능한 가장 독립적인 패키지 입니다.
- 네트워크 설정, Hive와 같은 저장소 설정, util 등이 이곳에 속합니다.

### 🗀 design_system
- 전역적으로 사용되는 앱의 에셋을 관리합니다.
- 폰트, 색상 테마 등이 이곳에 속합니다.

### 🗀 features
- 어플리케이션이 사용자에게 제공하는 기능을 중심으로 응집화되어있습니다. 
- 예를들어 ‘설정’, ‘로그인/회원가입’ 등은 각 사용자에게 제공하는 기능으로서 각 feature로 구분될 수 있습니다.

<br>


## Git branches & Conventions
- `angular js commit convention` 을 사용합니다.
- `dev`, `main`, `release/<version>`, `hotfix` 브랜치를 통해 CI/CD
- 특정 이슈에 대하여 `<issue주제>/issue/<issue번호>` 브랜치를 생성합니다.
- issue 주제는 다음과 같습니다
```
[feature]: 기능 추가 --> feature/issue/51

[fix]: 버그 수정 --> fix/issue/52

[refactor]: 리팩터 --> refactor/issue/12

여기에 없는 주제에 대해서는 알아서 눈치껏 하면 될듯.
```

## CI/CD
- Github Actions를 통해 지속적인 통합과 배포를 지원합니다.
- `dev`, `main`, `release/*`, `hotfix` 

### Play Console 배포

### `dev`
- 지속적으로 통합되는 브랜치로 Play Console에서 `내부 테스트 트랙`에 배포됩니다.
- `-alpha` 라는 suffix를 갖습니다. 예) `1.0.1-alpha`

### `main`
- 최신 프로덕션 코드 브랜치 입니다.
- Play Console에서 `프로덕션 트랙`에 배포됩니다.
- 정식 버전이기에 suffix 없습니다. 예) `1.0.1`

### `release/<version_name>`
- 특정 버전의 출시 직전 최종 버전 브랜치 입니다.
- Play Console의 `비공개 테스트 트랙`에 배포됩니다.
- `-rc` suffix를 갖습니다. 예) `1.0.1-rc`

### `hotfix`
- hotfix를 위한 브랜치 입니다.
- 빠른 배포를 위해 Play Console의 `내부테스트 트랙`에 배포되며 Play Console에서 직접 `프로덕션 트랙`에 배포해야 합니다.
- suffix는 존재하지 않습니다. `1.0.1`


### 워크플로우
```
Android 빌드

[브랜치 푸시 트리거]: [dev, main, release/*, hotfix] 브랜치에 푸시
 * docs: 로 시작하는 커밋에 대한 푸시는 무시됩니다

[어플리케이션 빌드]: 통해 브랜치 별 suffix 생성 및 버전 이름 변경후 .aab 빌드

[Google Play 배포]: [어플리케이션 빌드] 성공 시 브랜치 별 Play Console 트랙에 자동 배포

```