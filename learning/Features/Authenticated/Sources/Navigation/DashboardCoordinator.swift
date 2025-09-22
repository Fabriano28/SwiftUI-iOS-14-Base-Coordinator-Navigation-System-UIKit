//
//  DashboardDestination.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**
DashboardCoordinator manages the navigation flow for all screens that are accessible after a user has successfully logged in. It represents the main, authenticated experience of the app.

This coordinator is created and presented by the AppCoordinator when the AppState transitions to .authenticated.

Core Responsibilities:
Flow Management: Controls the navigation stack for the "authenticated" user flow, including screens like Home and Profile.

View Creation: Contains the logic for creating and configuring all views within its flow.

Dependency Injection: It passes necessary dependencies and navigation actions (as closures) to the views it creates, such as onProfileTapped or onLogoutTapped.

State Changes: It communicates with the AppStateManager when a user logs out, triggering a switch back to the AuthenticationCoordinator.

Properties:
router: An instance of Router that is specific to this coordinator's destinations (DashboardDestination). It holds the navigation path for the dashboard flow.

appStateManager: A reference to the global AppStateManager to report when the user logs out.

Key Functions:
start(): The entry point for this coordinator. It pushes the initial screen (.home) onto the router's path and returns the hosted UINavigationController view for this flow.

makeView(for:): A view builder function that constructs the correct SwiftUI view for a given DashboardDestination. It wires up the UI actions (e.g., button taps) to navigation logic (e.g., router.push(.profile)).
*/

import SwiftUI

private enum DashboardDestination: Navigatable {
    case home
    case profile
    var id: String { String(describing: self) }
}

@MainActor
class DashboardCoordinator: Coordinator {
    private let appStateManager: AppStateManager
    
    // It holds references to its child coordinators
    private var homeCoordinator: HomeCoordinator
    private var profileCoordinator: ProfileCoordinator

    init(
        appStateManager: AppStateManager,
        homeFactory: HomeFactoryProtocol,
        profileFactory: ProfileFactoryProtocol
    ) {
        self.appStateManager = appStateManager
        
        // The child coordinators are initialized with their own specific factories
        self.homeCoordinator = HomeCoordinator(
            appStateManager: appStateManager,
            factory: homeFactory
        )
        self.profileCoordinator = ProfileCoordinator(
            appStateManager: appStateManager,
            factory: profileFactory
        )
    }

    func start() -> AnyView {
        // The root view for this coordinator is the TabView container,
        // which gets its views from the child coordinators.
        return AnyView(
            AuthenticatedRootView(
                homeView: homeCoordinator.start(),
                profileView: profileCoordinator.start()
            )
        )
    }
}
