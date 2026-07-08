import SwiftUI

@main
struct HabitlyApp: App {
    @StateObject private var store: HabitStore

    init() {
        // Launchicken 스크린샷 모드에서는 실제 데이터 대신
        // 화면이 꽉 차 보이도록 현실감 있는 더미 데이터로 채운 스토어를 사용합니다.
        // 일반 실행에서는 기존과 동일한 기본 스토어를 사용합니다.
        if Launchicken.isScreenshotMode {
            _store = StateObject(wrappedValue: HabitStore(seedForScreenshots: true))
        } else {
            _store = StateObject(wrappedValue: HabitStore())
        }
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if let screen = Launchicken.targetScreen {
                    // 스크린샷 모드: 로그인/온보딩 없이 요청된 화면으로 바로 이동.
                    screenshotRoot(for: screen)
                } else {
                    TabView {
                        HomeView()
                            .tabItem { Label("오늘", systemImage: "checkmark.circle.fill") }
                        StatsView()
                            .tabItem { Label("통계", systemImage: "chart.bar.fill") }
                        SettingsView()
                            .tabItem { Label("설정", systemImage: "gearshape.fill") }
                    }
                }
            }
            .environmentObject(store)
        }
    }

    @ViewBuilder
    private func screenshotRoot(for screen: String) -> some View {
        switch screen {
        case "home":
            HomeView()
        case "stats":
            StatsView()
        case "new-habit":
            NewHabitView()
        case "settings":
            SettingsView()
        default:
            HomeView()
        }
    }
}
