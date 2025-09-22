//
//  HomeCoordinator.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

// CHILD coordinator for the Home tab.
// It manages all navigation within this specific tab.
private enum HomeDestination: Navigatable {
    case home
    var id: String { String(describing: self) }
}

@MainActor
class HomeCoordinator: Coordinator {
    private let router = Router<HomeDestination>()
    private let appStateManager: AppStateManager
    private let factory: HomeFactory // Receives the specific HomeFactory

    init(appStateManager: AppStateManager, factory: HomeFactory) {
        self.appStateManager = appStateManager
        self.factory = factory
    }

    func start() -> AnyView {
        router.push(.home)
        return AnyView(
            NavigationControllerHost(router: router) { destination in
                self.makeView(for: destination)
            }
        )
    }
    
    @ViewBuilder
    private func makeView(for destination: HomeDestination) -> some View {
        switch destination {
        case .home:
            factory.makeHomeView(
                onLogoutTapped: { self.appStateManager.setState(to: .unauthenticated) }
            )
        }
    }
}

