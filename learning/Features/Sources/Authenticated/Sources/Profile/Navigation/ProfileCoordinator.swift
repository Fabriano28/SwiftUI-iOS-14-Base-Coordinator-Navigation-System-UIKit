//
//  ProfileCoordinator.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//


import SwiftUI

// CHILD coordinator for the Profile tab.
private enum ProfileDestination: Navigatable {
    case profile
    case settings(data: SettingsData) // We can pass data to destinations
    
    var id: String {
        switch self {
        case .profile: return "profile"
        case .settings: return "settings"
        }
    }
    
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ProfileDestination, rhs: ProfileDestination) -> Bool {
        lhs.id == rhs.id
    }
}

@MainActor
class ProfileCoordinator: Coordinator {
    private let router = Router<ProfileDestination>()
    private let repository = MockDataRepository()
    private let appStateManager: AppStateManager
    private let factory: ProfileFactory

    init(appStateManager: AppStateManager, factory: ProfileFactory) {
        self.appStateManager = appStateManager
        self.factory = factory
    }
    
    func start() -> AnyView {
        router.push(.profile)
        return AnyView(
            NavigationControllerHost(router: router) { destination in
                self.makeView(for: destination)
            }
        )
    }
    
    @ViewBuilder
    private func makeView(for destination: ProfileDestination) -> some View {
        switch destination {
        case .profile:
            let useCase = GetUserProfileUseCase(repository: repository)
            let viewModel = ProfileViewModel(getUserProfileUseCase: useCase)
            ProfileView(
                viewModel: viewModel,
                onSettingsTapped: { settingsData in
                    self.router.push(.settings(data: settingsData))
                },
                onLogoutTapped: { self.appStateManager.setState(to: .unauthenticated) }
            )
        
        case .settings(let data):
            let viewModel = SettingsViewModel(initialData: data)
            SettingsView(viewModel: viewModel)
        }
    }
}

