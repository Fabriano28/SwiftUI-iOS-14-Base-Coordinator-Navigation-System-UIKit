//
//  HomeFactory.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

@MainActor
class HomeFactory: HomeFactoryProtocol { // BARE MINIMUM CHANGE: Conform to protocol.
    private let repository: MockDataRepository
    init(repository: MockDataRepository) { self.repository = repository }

    // BARE MINIMUM CHANGE: Update method signature.
    func makeHomeView(navigationDelegate: HomeViewNavigationDelegate) -> AnyView {
        let useCase = GetHomeDataUseCase(repository: repository)
        let viewModel = HomeViewModel(getHomeDataUseCase: useCase)
        return AnyView(
            HomeView(viewModel: viewModel, navigationDelegate: navigationDelegate)
        )
    }
}
