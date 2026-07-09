import XCTest

final class LaunchickenSnapshotsUITests: XCTestCase {
    func testLaunchickenScreenshots() throws {
        let app = XCUIApplication()
        app.launchArguments += ["--launchicken-screen=home"]
        app.launch()

        // TODO: Add setupSnapshot(app) and snapshot("home") after adding fastlane snapshot support.
        // TODO: Make your app route based on --launchicken-screen.
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 10))
    }
}
