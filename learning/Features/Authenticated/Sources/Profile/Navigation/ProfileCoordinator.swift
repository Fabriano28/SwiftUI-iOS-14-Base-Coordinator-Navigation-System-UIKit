//
//  ProfileDestination.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

private enum ProfileDestination: Navigatable {
    case profile
    case settings(data: SettingsData)
    var id: String {
        switch self {
        case .profile: return "profile"
        case .settings: return "settings"
        }
    }
    static func == (lhs: ProfileDestination, rhs: ProfileDestination) -> Bool {
        switch (lhs, rhs) {
        case (.profile, .profile): return true
        case let (.settings(lhsData), .settings(rhsData)): return lhsData == rhsData
        default: return false
        }
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        if case .settings(let data) = self { hasher.combine(data) }
    }
}

@MainActor
class ProfileCoordinator: Coordinator, ProfileViewNavigationDelegate {
    private let router = Router<ProfileDestination>()
    private let appStateManager: AppStateManager
    private let factory: ProfileFactoryProtocol

    init(appStateManager: AppStateManager, factory: ProfileFactoryProtocol) {
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
            factory.makeProfileView(navigationDelegate: self)
        case .settings(let data):
            factory.makeSettingsView(initialData: data)
        }
    }

    // MARK: - ProfileViewNavigationDelegate
    func profileViewDidTapSettings(with settingsData: SettingsData) {
        router.push(.settings(data: settingsData))
    }
    func profileViewDidTapLogout() {
        appStateManager.setState(to: .unauthenticated)
    }
}
