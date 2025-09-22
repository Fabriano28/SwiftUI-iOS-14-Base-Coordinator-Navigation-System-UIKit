//
//  LoginFactory.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

// Features/Unauthenticated/DI/LoginFactory.swift

import SwiftUI

@MainActor
class LoginFactory: LoginFactoryProtocol { // BARE MINIMUM CHANGE: Conform to protocol.
    // BARE MINIMUM CHANGE: Update method signature to match protocol.
    func makeLoginView(navigationDelegate: LoginViewNavigationDelegate) -> AnyView {
        AnyView(
            LoginView(navigationDelegate: navigationDelegate)
        )
    }
}
