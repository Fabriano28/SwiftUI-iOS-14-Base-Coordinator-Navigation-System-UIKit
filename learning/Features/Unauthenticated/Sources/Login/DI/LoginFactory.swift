//  Features/Unauthenticated/Sources/Login/DI/LoginFactory.swift

import SwiftUI

@MainActor
class LoginFactory {
    func makeLoginView(
        onLoginSuccess: @escaping () -> Void,
        onForgotPasswordTapped: @escaping () -> Void
    ) -> some View {
        LoginView(
            onLoginSuccess: onLoginSuccess,
            onForgotPasswordTapped: onForgotPasswordTapped
        )
    }
}