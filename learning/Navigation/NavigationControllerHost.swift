//
//  NavigationControllerHost.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

/**
NavigationControllerHost is a critical component that acts as a bridge between SwiftUI and UIKit's UINavigationController. It allows the use of a powerful, imperative UINavigationController within a declarative SwiftUI view hierarchy.

This is the key to achieving stable, programmatic navigation that is compatible with older iOS versions (like iOS 14-15) that do not have NavigationStack.

Core Responsibilities:
Wrapping UIKit: It uses UIViewControllerRepresentable to wrap and manage the lifecycle of a UINavigationController.

Two-Way State Synchronization: It ensures that the SwiftUI state (router.path) and the UIKit state (UINavigationController's view controllers) are always in sync.
1.  SwiftUI -> UIKit: When the router.path array changes, the updateUIViewController method is called. It creates UIHostingControllers for each destination in the path and sets them as the UINavigationController's view controllers.
2.  UIKit -> SwiftUI: When the user interacts with the UINavigationController directly (e.g., by tapping the back button or using a swipe gesture), the nested Coordinator class, acting as the UINavigationControllerDelegate, intercepts this event. It then updates the router.path array to match what UIKit is now showing, preventing state desynchronization.

Key Functions:
makeUIViewController(context:): Creates the initial UINavigationController and sets its delegate.

updateUIViewController(_:context:): Responds to changes in the SwiftUI state (router.path) and updates the UIKit view controller stack accordingly.

makeCoordinator(): Creates the delegate object that listens for navigation events from the UINavigationController.
*/

import SwiftUI
import UIKit

struct NavigationControllerHost<Destination: Navigatable, Content: View>: UIViewControllerRepresentable {
    @ObservedObject var router: Router<Destination>
    private let viewBuilder: (Destination) -> Content

    init(router: Router<Destination>, @ViewBuilder viewBuilder: @escaping (Destination) -> Content) {
        self.router = router
        self.viewBuilder = viewBuilder
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.delegate = context.coordinator
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        if uiViewController.viewControllers.count < router.path.count {
            let newViewControllers = router.path.map { destination -> UIViewController in
                let hostingController = UIHostingController(rootView: viewBuilder(destination))
                hostingController.view.tag = destination.hashValue
                return hostingController
            }
            uiViewController.setViewControllers(newViewControllers, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(router: router)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate {
        var router: Router<Destination>

        init(router: Router<Destination>) {
            self.router = router
        }

        func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
            guard let didShowDestinationTag = navigationController.viewControllers.last?.view.tag else { return }
            
            if router.path.count > navigationController.viewControllers.count {
                if let lastMatchingIndex = router.path.lastIndex(where: { $0.hashValue == didShowDestinationTag }) {
                    // This correctly trims the SwiftUI state to match what UIKit is showing.
                    router.path = Array(router.path.prefix(lastMatchingIndex + 1))
                }
            }
        }
    }
}
