//
//  LoginFactoryProtocol.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import Foundation
import SwiftUI

@MainActor
protocol LoginFactoryProtocol {
    func makeLoginView(navigationDelegate: LoginViewNavigationDelegate) -> AnyView
}
