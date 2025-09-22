//
//  AppState.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**
A critical component that acts as the single source of truth for the application's high-level state. It determines whether the user is in an unauthorized or authenticated state, driving the main navigation flow of the entire app.

Core Responsibilities
State Management: Holds the currentState of the application in a @Published property, allowing other objects (like the AppCoordinator) to observe and react to changes.

State Transition: Provides a single, safe method (setState(to:)) for changing the app's state.

Animation Control: Wraps state changes in a withAnimation block to ensure smooth, animated transitions between major flows (e.g., animating from the login screen to the dashboard).

Properties
@Published currentState: The current AppState of the application. It is private(set) to ensure that it can only be modified via the setState(to:) method.

@Published transitionDirection: An enum that tracks whether the state change was a "forward" (e.g., login) or "backward" (e.g., logout) transition. This can be used for more advanced custom animations.

Supporting Enums
AppState: Defines the possible high-level states of the app. Making it Comparable allows for easy determination of the transition direction.

TransitionDirection: Defines the direction of a state change.

Key Functions
setState(to:): The sole entry point for changing the application's state. It calculates the transition direction and updates the currentState within an animation block.
*/

import Foundation
import SwiftUI

enum AppState: Int, Comparable {
    case unauthorized = 0
    case authenticated = 1

    static func < (lhs: AppState, rhs: AppState) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

enum TransitionDirection {
    case forward, backward
}

@MainActor
final class AppStateManager: ObservableObject {
    @Published private(set) var currentState: AppState = .unauthorized
    @Published private(set) var transitionDirection: TransitionDirection = .forward
    
    private var previousState: AppState = .unauthorized

    func setState(to newState: AppState) {
        if newState > self.currentState {
            self.transitionDirection = .forward
        } else {
            self.transitionDirection = .backward
        }
        
        withAnimation(.easeInOut(duration: 0.35)) {
            self.currentState = newState
        }
    }
}
