import Foundation

/// Launchicken 스크린샷 자동화를 위한 helper.
/// CI에서 앱을 빌드해 시뮬레이터에 설치한 뒤
/// `--launchicken-screen=<name>` 런치 아규먼트를 주면
/// 로그인/온보딩 없이 지정한 화면으로 바로 이동시키고
/// 실제 데이터처럼 보이는 더미 데이터를 채워 스크린샷을 찍습니다.
/// 이 아규먼트가 없으면 앱은 기존과 완전히 동일하게 동작합니다.
enum Launchicken {
    /// 스크린샷 모드 여부. 일반 실행에서는 항상 false.
    static let isScreenshotMode: Bool = {
        ProcessInfo.processInfo.arguments.contains { $0.hasPrefix("--launchicken-screen=") }
    }()

    /// 요청된 화면 이름 (예: "home", "stats", "new-habit", "settings")
    static let targetScreen: String? = {
        guard let arg = ProcessInfo.processInfo.arguments.first(where: { $0.hasPrefix("--launchicken-screen=") }) else {
            return nil
        }
        return String(arg.dropFirst("--launchicken-screen=".count))
    }()
}
