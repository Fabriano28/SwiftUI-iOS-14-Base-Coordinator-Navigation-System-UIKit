//
//  ProfileFactory.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

@MainActor
class ProfileFactory: ProfileFactoryProtocol { // BARE MINIMUM CHANGE: Conform to protocol.
    private let repository: MockDataRepository
    init(repository: MockDataRepository) { self.repository = repository }

    // BARE MINIMUM CHANGE: Update method signatures.
    func makeProfileView(navigationDelegate: ProfileViewNavigationDelegate) -> AnyView {
        let useCase = GetUserProfileUseCase(repository: repository)
        let viewModel = ProfileViewModel(getUserProfileUseCase: useCase)
        return AnyView(
            ProfileView(viewModel: viewModel, navigationDelegate: navigationDelegate)
        )
    }

    func makeSettingsView(initialData: SettingsData) -> AnyView { // 👈 Simplified
        let viewModel = SettingsViewModel(initialData: initialData)
        return AnyView(
            SettingsView(viewModel: viewModel)
        )
    }
}
