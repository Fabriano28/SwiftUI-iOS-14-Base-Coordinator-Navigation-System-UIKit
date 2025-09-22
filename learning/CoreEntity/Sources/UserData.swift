//
//  UserData.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let name: String
    let email: String
}

// BARE MINIMUM CHANGE: Make the struct conform to Hashable.
struct SettingsData: Hashable {
    var notificationsEnabled: Bool
    var theme: String
}
