//
//  HomeFactoryProtocol.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//

import SwiftUI

@MainActor
protocol HomeFactoryProtocol {
    func makeHomeView(navigationDelegate: HomeViewNavigationDelegate) -> AnyView
}
