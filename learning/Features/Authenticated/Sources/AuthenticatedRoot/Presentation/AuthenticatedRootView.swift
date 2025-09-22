//
//  AuthenticatedRootView.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//


import SwiftUI

struct AuthenticatedRootView: View {
    let homeView: AnyView
    let profileView: AnyView

    var body: some View {
        TabView {
            homeView
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            profileView
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

