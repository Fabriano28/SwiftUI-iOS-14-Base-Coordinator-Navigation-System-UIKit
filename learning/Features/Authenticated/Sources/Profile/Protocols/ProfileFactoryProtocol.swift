//
//  ProfileFactoryProtocol.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

@MainActor
protocol ProfileFactoryProtocol {
    func makeProfileView(navigationDelegate: ProfileViewNavigationDelegate) -> AnyView
    func makeSettingsView(initialData: SettingsData) -> AnyView // 👈 Simplified
}
