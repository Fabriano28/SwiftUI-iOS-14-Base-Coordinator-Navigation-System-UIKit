//
//  SettingsView.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//


import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel

    var body: some View {
        Form {
            Section(header: Text("Preferences")) {
                Toggle("Enable Notifications", isOn: $viewModel.settingsData.notificationsEnabled)
                Text("Current Theme: \(viewModel.settingsData.theme)")
            }
            
            // Example of a subview
            InfoRowView(title: "Version", value: "1.0.0")
        }
        .navigationTitle("Settings")
    }
}

// Example of how subviews can be organized.
// For a simple view like this, it's fine in the same file.
// For a more complex subview, it would get its own file in a `Subviews` folder.
struct InfoRowView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value).foregroundColor(.gray)
        }
    }
}

