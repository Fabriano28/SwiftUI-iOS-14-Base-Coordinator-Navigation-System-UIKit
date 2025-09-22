//
//  ProfileView.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**

View Documentation (LoginView, ForgotPasswordView, HomeView, ProfileView)
All views in this project follow the same architectural principle: they are "dumb" views, meaning they are responsible only for presenting UI and reporting user actions.

Core Principles:
UI Presentation: A view's only job is to lay out UI components (Text, Buttons, etc.) and apply styling.

State Agnostic: Views do not contain any business logic or navigation state. They don't know what happens when a button is tapped, only that they should report the tap.

Dependency Injection via Closures: Views receive their actions as simple closures (e.g., onLoginTapped: () -> Void). These closures are provided by the coordinator that creates the view. When a user interacts with a button, the view simply executes the corresponding closure.

Reusability & Testability: This decoupling makes views highly reusable and easy to test in isolation, as you only need to provide mock closures to check their behavior.

Example (HomeView):
struct HomeView: View {
    // These actions are provided by the DashboardCoordinator.
    var onProfileTapped: () -> Void
    var onLogoutTapped: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Home").font(.largeTitle)
            // The view doesn't know what onProfileTapped does, it just calls it.
            Button("Go to Profile", action: onProfileTapped)
            Button("Log Out", action: onLogoutTapped)
        }
        .navigationTitle("Home") // Configures the nav bar provided by the host.
    }
}

*/

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    // BARE MINIMUM CHANGE: Replaced closures with the delegate protocol.
    var navigationDelegate: ProfileViewNavigationDelegate
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView()
            } else if let user = viewModel.user {
                Text(user.name).font(.largeTitle)
                Text(user.email).font(.headline)
                if let settings = viewModel.settings {
                    Button("Go to Settings") {
                        // BARE MINIMUM CHANGE: Call the delegate method.
                        navigationDelegate.profileViewDidTapSettings(with: settings)
                    }
                }
                Button("Log Out", action: {
                    // BARE MINIMUM CHANGE: Call the delegate method.
                    navigationDelegate.profileViewDidTapLogout()
                })
            }
        }
        .navigationTitle("User Profile")
        .onAppear { viewModel.onAppear() }
    }
}
