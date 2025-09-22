//
//  AppCoordinator.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**
AppCoordinator is the master coordinator for the entire application. It acts as the primary navigation controller at the root level, deciding which major user flow to present based on the application's current state.

Core Responsibilities:
Lifecycle Management: It is initialized at app launch and holds a reference to the main UIWindow.

State Observation: It subscribes to changes in the AppStateManager.

Flow Switching: Based on the AppState (e.g., .unauthorized or .authenticated), it creates and presents the appropriate feature-level coordinator (AuthenticationCoordinator or DashboardCoordinator).

Root View Controller: It manages a root UINavigationController that serves as the host for the different coordinators' views.

Key Components:
window: The main UIWindow of the application, required to set the root view controller.

appStateManager: The single source of truth for the app's global state.

rootNavigationController: A UINavigationController instance that holds the view hierarchy. This allows for native push/pop animations.

Key Functions:
init(window:appStateManager:): Sets up the coordinator, hides the root navigation bar (as it's just a container), and begins listening for state changes.

listenForStateChanges(): Creates a Combine subscription to the appStateManager.$currentState publisher.

handle(state:): The core logic that responds to state changes. It constructs the correct coordinator, gets its starting view, and sets it as the new view controller stack on the rootNavigationController.
*/

import SwiftUI
import Combine

@MainActor
class AppCoordinator {
    let window: UIWindow
    private let appStateManager: AppStateManager
    // Use a UINavigationController as the root to manage transitions
    private let rootNavigationController = UINavigationController()
    private var cancellables = Set<AnyCancellable>()
    private let factory: AppFactory

    init(window: UIWindow, appStateManager: AppStateManager, factory: AppFactory) {
        self.window = window
        self.appStateManager = appStateManager
        self.factory = factory
        
        // The root controller is just a container, so its own nav bar should be hidden.
        rootNavigationController.isNavigationBarHidden = true
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        listenForStateChanges()
    }

    private func listenForStateChanges() {
        appStateManager.$currentState
            .removeDuplicates()
            .sink { [weak self] state in
                self?.handle(state: state)
            }
            .store(in: &cancellables)
    }

    // This logic now uses the UINavigationController's stack to manage the flows
    private func handle(state: AppState) {
        switch state {
        case .unauthenticated:
            let authCoordinator = AuthenticationCoordinator(
                appStateManager: appStateManager,
                loginFactory: factory.loginFactory
            )
            let authView = authCoordinator.start()
            let authVC = UIHostingController(rootView: authView)
            
            // When returning to unauthenticated, we pop all the way to the root.
            rootNavigationController.popToRootViewController(animated: true)
            rootNavigationController.setViewControllers([authVC], animated: false)

        case .authenticated:
            let dashboardCoordinator = DashboardCoordinator(
                appStateManager: appStateManager,
                homeFactory: factory.homeFactory,
                profileFactory: factory.profileFactory
            )
            let dashboardView = dashboardCoordinator.start()
            let dashboardVC = UIHostingController(rootView: dashboardView)
            
            // When logging in, we push the new flow onto the stack.
            rootNavigationController.pushViewController(dashboardVC, animated: true)
        }
    }
}
