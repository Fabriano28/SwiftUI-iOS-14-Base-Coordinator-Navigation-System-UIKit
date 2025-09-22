
# SwiftUI Coordinator Navigation System

This document provides a guide on how to use the state-driven Coordinator navigation system in this project. This architecture is designed to be stable, scalable, and testable, providing a robust solution for managing complex navigation flows in SwiftUI, especially for apps supporting iOS 14+.

## Core Concepts

The navigation system is built upon a few key components that work together to manage the application's state and UI flow.

- **AppStateManager**: The global "source of truth." It holds the high-level state of the app (e.g., .unauthorized, .authenticated) and drives which major flow is currently active.

- **AppCoordinator**: The root coordinator. It observes the AppStateManager and swaps child coordinators in and out (e.g., showing AuthenticationCoordinator for the login flow, or DashboardCoordinator for the main app).

- **Feature Coordinators (AuthenticationCoordinator, DashboardCoordinator)**: Each coordinator manages a self-contained feature or user flow. It is responsible for creating views and handling navigation within that flow.

- **Router**: An ObservableObject owned by a feature coordinator. It holds the navigation stack for that flow as an array of destinations (path). All navigation actions (push, pop) are performed by manipulating this array.

- **NavigationControllerHost**: A crucial bridge that wraps a UIKit UINavigationController, allowing us to leverage its robust navigation capabilities (like push/pop animations and gesture handling) within a SwiftUI environment. It observes a Router and automatically updates its view controller stack whenever the path array changes.
## How to Add a New Screen to a Flow

Here is a step-by-step guide to adding a new "Settings" screen to the authenticated dashboard flow.

**Step 1:** Define the Destination
First, declare the new screen as a destination. Open DashboardCoordinator.swift and add a new case to the DashboardDestination enum.

```swift
// In DashboardCoordinator.swift

private enum DashboardDestination: Navigatable {
    case home
    case profile
    case settings // 👈 Add the new destination case
    var id: String { String(describing: self) }
}
```

**Step 2:** Create the SwiftUI View
Create a new SwiftUI view file named SettingsView.swift. Following our architecture, this should be a "dumb" view that only presents UI and calls closures for any actions.

```swift
// SettingsView.swift

import SwiftUI

struct SettingsView: View {
    var onDoneTapped: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings").font(.largeTitle)
            Button("Done", action: onDoneTapped)
        }
        .navigationTitle("Settings")
    }
}
```

**Step 3:** Teach the Coordinator How to Build the View
Now, open DashboardCoordinator.swift and update the makeView(for:) function to handle the new .settings case. Here, you will instantiate SettingsView and provide the implementation for its onDoneTapped action.

```swift
// In DashboardCoordinator.swift

@ViewBuilder
private func makeView(for destination: DashboardDestination) -> some View {
    switch destination {
    case .home:
        HomeView(
            onProfileTapped: { self.router.push(.profile) },
            // We will add the action to navigate to settings here later
            onLogoutTapped: { self.appStateManager.setState(to: .unauthorized) }
        )
    case .profile:
        ProfileView(
            onLogoutTapped: { self.appStateManager.setState(to: .unauthorized) }
        )
    // 👇 Add the new case to the switch statement
    case .settings:
        SettingsView(
            // When "Done" is tapped, we pop the current view from the stack.
            onDoneTapped: { self.router.pop() }
        )
    }
}
```

**Step 4:** Trigger the Navigation
Finally, trigger the navigation from an existing screen. We'll add a "Go to Settings" button in HomeView.

First, update HomeView.swift to accept a new action closure.

```swift
// In HomeView.swift

struct HomeView: View {
    var onProfileTapped: () -> Void
    var onSettingsTapped: () -> Void // 👈 Add new action
    var onLogoutTapped: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Home").font(.largeTitle)
            Button("Go to Profile", action: onProfileTapped)
            Button("Go to Settings", action: onSettingsTapped) // 👈 Add new button
            Button("Log Out", action: onLogoutTapped)
        }
        .navigationTitle("Home")
    }
}
```

Then, update the DashboardCoordinator to provide this new action when it creates the HomeView.

```swift
// In DashboardCoordinator.swift's makeView(for:) function

case .home:
    HomeView(
        onProfileTapped: { self.router.push(.profile) },
        onSettingsTapped: { self.router.push(.settings) }, // 👈 Provide the implementation
        onLogoutTapped: { self.appStateManager.setState(to: .unauthorized) }
    )
```swift

That's it! The navigation is now fully wired up.
