# Habitly — Launchicken Demo App

작은 습관 트래커 iOS 앱입니다. [Launchicken](https://github.com/inhwangYang/codex_launchicken)의
스크린샷 자동화 파이프라인을 시연·테스트하기 위한 공개 데모 레포입니다.

- SwiftUI, iOS 17+, 외부 의존성 없음
- 화면: 오늘의 습관(home) / 통계(stats) / 새 습관 만들기(new-habit) / 설정(settings)
- 의도적으로 Launchicken 연동 코드가 없는 상태로 유지됩니다 — AI 설정 PR 기능이
  이 레포를 상대로 라우팅/데모 데이터 코드를 작성하는 것을 반복 테스트하기 위해서입니다.

빌드: `xcodegen generate` 후 `Habitly.xcodeproj` 열기 (또는 커밋된 xcodeproj 그대로 사용)
