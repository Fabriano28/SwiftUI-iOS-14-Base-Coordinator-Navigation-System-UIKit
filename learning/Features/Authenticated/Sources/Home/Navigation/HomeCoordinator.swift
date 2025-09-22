//
//  HomeDestination.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

private enum HomeDestination: Navigatable {
    case home
    var id: String { String(describing: self) }
}

@MainActor
class HomeCoordinator: Coordinator, HomeViewNavigationDelegate {
    private let router = Router<HomeDestination>()
    private let appStateManager: AppStateManager
    private let factory: HomeFactoryProtocol

    init(appStateManager: AppStateManager, factory: HomeFactoryProtocol) {
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
            factory.makeHomeView(navigationDelegate: self)
        }
    }
    
    // MARK: - HomeViewNavigationDelegate
    func homeViewDidTapLogout() {
        appStateManager.setState(to: .unauthenticated)
    }
}
