import SwiftUI

@main
struct HabitlyApp: App {
    @StateObject private var store = HabitStore()

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem { Label("오늘", systemImage: "checkmark.circle.fill") }
                StatsView()
                    .tabItem { Label("통계", systemImage: "chart.bar.fill") }
                SettingsView()
                    .tabItem { Label("설정", systemImage: "gearshape.fill") }
            }
            .environmentObject(store)
        }
    }
}
