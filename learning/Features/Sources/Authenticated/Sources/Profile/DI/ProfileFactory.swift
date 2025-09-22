//
//  ProfileFactory.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

@MainActor
class ProfileFactory {
    private let repository: MockDataRepository

    init(repository: MockDataRepository) {
        self.repository = repository
    }

    func makeProfileView(
        onSettingsTapped: @escaping (SettingsData) -> Void,
        onLogoutTapped: @escaping () -> Void
    ) -> some View {
        let useCase = GetUserProfileUseCase(repository: repository)
        let viewModel = ProfileViewModel(getUserProfileUseCase: useCase)
        return ProfileView(
            viewModel: viewModel,
            onSettingsTapped: onSettingsTapped,
            onLogoutTapped: onLogoutTapped
        )
    }

    func makeSettingsView(initialData: SettingsData) -> some View {
        let viewModel = SettingsViewModel(initialData: initialData)
        return SettingsView(viewModel: viewModel)
    }
}
