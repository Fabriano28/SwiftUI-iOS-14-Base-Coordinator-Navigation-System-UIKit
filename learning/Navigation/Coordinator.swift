//
//  Coordinator.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**
The Coordinator protocol defines a common interface for all coordinator objects in the application.

Purpose:
Its primary purpose is to establish a consistent pattern for initializing and starting a navigation flow. By conforming to this protocol, every coordinator guarantees that it has a start() method that can be called to retrieve its main view.

This simplifies the logic in parent coordinators (like AppCoordinator), which don't need to know the specific type of a child coordinator, only that they can call start() on it.

Requirements:
start(): A function that must be implemented by any conforming type. This function is responsible for setting up the coordinator's initial state and returning the root view of its navigation flow, wrapped in AnyView. The function must be executable on the main actor.
*/

import SwiftUI

protocol Coordinator {
    @MainActor func start() -> AnyView
}
