import Foundation

/// Launchicken launches the app once per store screenshot with `--launchicken-screen=<name>`.
/// Copy this file into your app target and route to the requested screen at launch,
/// otherwise every screenshot shows the same first screen of the app.
enum LaunchickenScreen {
    /// The screen name requested by Launchicken, e.g. "home" or "settings". Nil in normal runs.
    static var requested: String? {
        let prefix = "--launchicken-screen="
        for argument in ProcessInfo.processInfo.arguments where argument.hasPrefix(prefix) {
            return String(argument.dropFirst(prefix.count))
        }
        return nil
    }
}

// Example SwiftUI usage:
//
// @main
// struct MyApp: App {
//     var body: some Scene {
//         WindowGroup {
//             switch LaunchickenScreen.requested {
//             case "settings":
//                 SettingsView()
//             case "paywall":
//                 PaywallView()
//             default:
//                 ContentView()
//             }
//         }
//     }
// }
//
// Example UIKit usage (in SceneDelegate / AppDelegate):
//
// if let screen = LaunchickenScreen.requested {
//     window?.rootViewController = viewController(forLaunchickenScreen: screen)
// }
