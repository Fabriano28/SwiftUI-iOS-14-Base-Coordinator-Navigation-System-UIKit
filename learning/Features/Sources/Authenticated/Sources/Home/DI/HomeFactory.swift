//
//  HomeFactory.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

@MainActor
class HomeFactory {
    private let repository: MockDataRepository

    init(repository: MockDataRepository) {
        self.repository = repository
    }

    func makeHomeView(onLogoutTapped: @escaping () -> Void) -> some View {
        let useCase = GetHomeDataUseCase(repository: repository)
        let viewModel = HomeViewModel(getHomeDataUseCase: useCase)
        return HomeView(
            viewModel: viewModel,
            onLogoutTapped: onLogoutTapped
        )
    }
}
