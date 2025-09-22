//
//  Navigatable.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**
Router is a generic, observable class that manages the navigation state for a specific coordinator. It acts as the source of truth for a navigation stack.

Each coordinator (AuthenticationCoordinator, DashboardCoordinator) owns its own instance of a Router.

Core Responsibilities:
State Management: Holds the navigation stack in its @Published var path property. This array represents the ordered list of screens currently in the navigation hierarchy.

Programmatic Navigation: Provides simple methods (push, pop, popToRoot) to manipulate the navigation stack programmatically.

UI Updates: Because path is a @Published property, any changes to it will automatically trigger a UI update in the NavigationControllerHost that is observing it.

Protocols:
Navigatable: A protocol that all navigation destinations (e.g., AuthDestination, DashboardDestination) must conform to. Requiring Hashable and Identifiable allows the Router and NavigationControllerHost to efficiently track and update the views in the navigation stack.

Properties:
@Published path: An array of Destinations. This is the source of truth for the current navigation stack.

Key Functions:
push(_:): Appends a new destination to the end of the path, effectively pushing a new screen onto the stack.

pop(): Removes the last destination from the path, popping the current screen off the stack.
*/

import SwiftUI

// A protocol that all navigable destinations must conform to.
protocol Navigatable: Hashable, Identifiable {}

// An ObservableObject that holds the navigation stack for a given coordinator.
// The `path` is the source of truth for the navigation state.
@MainActor
final class Router<Destination: Navigatable>: ObservableObject {
    @Published var path: [Destination] = []

    func push(_ destination: Destination) {
        path.append(destination)
    }

    func pop() {
        _ = path.popLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}


