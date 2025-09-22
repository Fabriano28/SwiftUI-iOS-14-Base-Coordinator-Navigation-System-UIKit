//
//  ProfileViewNavigationDelegate.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import Foundation

@MainActor
protocol ProfileViewNavigationDelegate {
    func profileViewDidTapSettings(with settingsData: SettingsData)
    func profileViewDidTapLogout()
}
