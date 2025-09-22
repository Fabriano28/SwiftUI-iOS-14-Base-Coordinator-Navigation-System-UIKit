//
//  LoginViewNavigationDelegate.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import Foundation

@MainActor
protocol LoginViewNavigationDelegate {
    func loginViewDidSucceed()
    func loginViewDidTapForgotPassword()
}
