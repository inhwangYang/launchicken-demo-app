# Launchicken Screenshot Setup

Detected project type: `native`.

Launchicken created a safe screenshot scaffold. The scaffold does not assume your navigation,
login state, test dependencies, or app architecture.

## How to make real screenshots

1. Open `launchicken/screenshots.yml` and list every store screen you want, such as
   `home`, `settings`, or `paywall`. The iOS fastlane lane captures one screenshot per
   entry under `ios.screens`, so adding a screen here is how you add a screenshot.
2. Wire your app to read Launchicken screen hints and open the matching screen:
   - iOS: launch argument `--launchicken-screen=home`. Copy
     `launchicken/scaffold/ios/LaunchickenScreenRouting.swift` into your app target and
     switch on `LaunchickenScreen.requested` at startup. Without this routing, every
     screenshot shows the same first screen of the app.
   - Android: intent extra `launchicken_screen=home`
   - Flutter: test route/config for the target screen
3. Move the relevant scaffold file into your real test target.
4. Update the workflow or fastlane lane to run the real screenshot command.

Until this is wired, Launchicken may generate placeholder artifacts or capture the
simulator home screen instead of real app screenshots.
