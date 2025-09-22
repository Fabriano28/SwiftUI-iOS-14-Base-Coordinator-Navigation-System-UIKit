//
//  AuthDestination.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**
AuthenticationCoordinator manages the navigation flow for all screens related to user authentication. It is responsible for the entire user experience before a user is logged in.

This coordinator is created and presented by the AppCoordinator when the AppState is .unauthorized.

Core Responsibilities:
Flow Management: Controls the navigation stack for the "unauthorized" user flow, including screens like Login and Forgot Password.

View Creation: Contains the logic for creating and configuring all views within its flow (e.g., LoginView, ForgotPasswordView).

Dependency Injection: It passes necessary dependencies and navigation actions (as closures) to the views it creates. This decouples the views from the navigation logic.

State Changes: It communicates with the AppStateManager to signal when the user has successfully authenticated, triggering a switch to the DashboardCoordinator.

Properties:
router: An instance of Router that is specific to this coordinator's destinations (AuthDestination). It holds the navigation path for the authentication flow.

appStateManager: A reference to the global AppStateManager to report authentication success.

Key Functions:
start(): The entry point for this coordinator. It pushes the initial screen (.login) onto the router's path and returns the hosted UINavigationController view for this flow.

makeView(for:): A view builder function that constructs the correct SwiftUI view for a given AuthDestination. It's here that navigation closures (like onLoginTapped) are created and passed to the views.
*/

import SwiftUI

private enum AuthDestination: Navigatable {
    case login
    case forgotPassword
    var id: String { String(describing: self) }
}

@MainActor
class AuthenticationCoordinator: Coordinator, LoginViewNavigationDelegate {
    private let router = Router<AuthDestination>()
    private let appStateManager: AppStateManager
    private let loginFactory: LoginFactoryProtocol

    init(appStateManager: AppStateManager, loginFactory: LoginFactoryProtocol) {
        self.appStateManager = appStateManager
        self.loginFactory = loginFactory
    }

    func start() -> AnyView {
        router.push(.login)
        return AnyView(
            NavigationControllerHost(router: router) { destination in
                self.makeView(for: destination)
            }
        )
    }

    @ViewBuilder
    private func makeView(for destination: AuthDestination) -> some View {
        switch destination {
        case .login:
            loginFactory.makeLoginView(navigationDelegate: self)
        case .forgotPassword:
            ForgotPasswordView()
        }
    }
    
    // MARK: - LoginViewNavigationDelegate
    func loginViewDidSucceed() {
        appStateManager.setState(to: .authenticated)
    }
    
    func loginViewDidTapForgotPassword() {
        router.push(.forgotPassword)
    }
}
