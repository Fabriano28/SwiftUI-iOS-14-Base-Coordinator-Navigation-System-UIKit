//
//  LoginFactory.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

@MainActor
class LoginFactory {
    func makeLoginView(
        onLoginTapped: @escaping () -> Void,
        onForgotPasswordTapped: @escaping () -> Void
    ) -> some View {
        LoginView(
            onLoginTapped: onLoginTapped,
            onForgotPasswordTapped: onForgotPasswordTapped
        )
    }
}
