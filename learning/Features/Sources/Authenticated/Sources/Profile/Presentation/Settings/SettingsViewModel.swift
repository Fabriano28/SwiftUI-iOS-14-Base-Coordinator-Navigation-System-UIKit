//
//  SettingsViewModel.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//


import Foundation
import Combine

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var settingsData: SettingsData

    init(initialData: SettingsData) {
        self.settingsData = initialData
    }
    
    func toggleNotifications() {
        settingsData.notificationsEnabled.toggle()
    }
}

