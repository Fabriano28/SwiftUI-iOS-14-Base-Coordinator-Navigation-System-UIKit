//
//  GetUserProfileUseCase.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//


import Foundation

// Use Case for fetching all the necessary data for the profile screen.
struct GetUserProfileUseCase {
    private let repository: MockDataRepository

    init(repository: MockDataRepository) {
        self.repository = repository
    }
    
    // A single use case can combine multiple repository calls
    func execute() async -> (user: User, settings: SettingsData) {
        async let user = repository.getUserProfile()
        async let settings = repository.getSettings()
        return await (user, settings)
    }
}

