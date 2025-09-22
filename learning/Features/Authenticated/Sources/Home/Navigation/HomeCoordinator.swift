//
//  HomeDestination.swift
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
    private let repository = MockDataRepository()

    init(appStateManager: AppStateManager) {
        self.appStateManager = appStateManager
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
            // The coordinator creates the entire MVVM stack for the view
            let getHomeDataUseCase = GetHomeDataUseCase(repository: repository)
            let viewModel = HomeViewModel(getHomeDataUseCase: getHomeDataUseCase)
            HomeView(
                viewModel: viewModel,
                onLogoutTapped: { self.appStateManager.setState(to: .unauthenticated) }
            )
        }
    }
}

