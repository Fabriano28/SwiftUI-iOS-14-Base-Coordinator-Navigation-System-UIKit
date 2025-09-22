//
//  MockDataRepository.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//


import Foundation
import Combine

// This is a mock repository that simulates network calls.
// In a real app, this would use URLSession to talk to a real API.
class MockDataRepository {

    // Simulates fetching a welcome message for the home screen.
    func getHomeWelcomeMessage() async -> String {
        // Simulate a network delay of 1 second
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return "Welcome to your Dashboard!"
    }

    // Simulates fetching user data for the profile screen.
    func getUserProfile() async -> User {
        // Simulate a network delay of 1.5 seconds
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        return User(id: UUID(), name: "Farrel Brian", email: "farrel.brian@example.com")
    }
    
    // Simulates fetching the current settings.
    func getSettings() async -> SettingsData {
        try? await Task.sleep(nanoseconds: 500_000_000)
        return SettingsData(notificationsEnabled: true, theme: "Dark")
    }
}
