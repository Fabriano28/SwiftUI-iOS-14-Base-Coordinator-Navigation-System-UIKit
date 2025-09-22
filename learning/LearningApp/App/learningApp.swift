//
//  learningApp.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**
learningApp is the main entry point for the application, conforming to SwiftUI's App protocol.

Core Responsibilities:
State Ownership: It creates and owns the single instance of the AppStateManager. By declaring it as a @StateObject, it ensures the state manager's lifecycle is tied to the app's lifecycle.

Coordinator Initialization: It is responsible for creating the root AppCoordinator.

Window Access: It uses a helper utility, WindowAccessor, to get a reference to the scene's underlying UIWindow. This is a necessary step because the AppCoordinator requires the window to install its root view controller.

Components:
appStateManager: The singleton instance of the app's state manager.

appCoordinator: The optional root coordinator. It's optional because it can only be initialized after the UIWindow becomes available.

WindowAccessor: A UIViewControllerRepresentable helper struct designed for one purpose: to access the UIWindow from within a SwiftUI view hierarchy and provide it via a callback.
*/

import SwiftUI

@main
struct learningApp: App {
    @StateObject private var appStateManager = AppStateManager()
    @State private var appCoordinator: AppCoordinator?
    private let appFactory = AppFactory() // Create the single AppFactory

    var body: some Scene {
        WindowGroup {
            WindowAccessor { window in
                if appCoordinator == nil {
                    self.appCoordinator = AppCoordinator(
                        window: window,
                        appStateManager: appStateManager,
                        factory: appFactory // Pass the AppFactory
                    )
                }
            }
            .ignoresSafeArea()
        }
    }
}

// Helper view to get access to the underlying UIWindow of a scene
struct WindowAccessor: UIViewControllerRepresentable {
    var callback: (UIWindow) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            if let window = controller.view.window {
                self.callback(window)
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
