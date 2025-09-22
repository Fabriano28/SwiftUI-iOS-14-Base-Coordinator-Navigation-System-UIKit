//
//  GetHomeDataUseCase.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//


import Foundation

// A Use Case encapsulates a single piece of business logic.
// It acts as a bridge between the ViewModel and the Data layer.
struct GetHomeDataUseCase {
    private let repository: MockDataRepository

    init(repository: MockDataRepository) {
        self.repository = repository
    }
    
    func execute() async -> String {
        return await repository.getHomeWelcomeMessage()
    }
}

