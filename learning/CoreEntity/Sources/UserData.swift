//
//  UserData.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import Foundation

// Represents the main user object
struct User: Identifiable {
    let id: UUID
    let name: String
    let email: String
}

// Represents data that might be passed to the settings screen
struct SettingsData {
    var notificationsEnabled: Bool
    var theme: String
}
