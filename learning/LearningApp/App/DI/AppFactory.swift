//
//  AppFactory.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import Foundation

@MainActor
class AppFactory {
    private let repository = MockDataRepository()

    // Create factories for each feature module
    lazy var loginFactory = LoginFactory()
    lazy var homeFactory = HomeFactory(repository: repository)
    lazy var profileFactory = ProfileFactory(repository: repository)
    // ... other factories would go here
}
