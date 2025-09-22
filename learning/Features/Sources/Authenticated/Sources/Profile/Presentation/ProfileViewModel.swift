//
//  ProfileViewModel.swift
//  learning
//
//  Created by Farrel Brian Rafi on 22/09/25.
//


import Foundation
import Combine

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var settings: SettingsData?
    @Published var isLoading = true
    
    private let getUserProfileUseCase: GetUserProfileUseCase

    init(getUserProfileUseCase: GetUserProfileUseCase) {
        self.getUserProfileUseCase = getUserProfileUseCase
    }
    
    func onAppear() {
        Task {
            let result = await getUserProfileUseCase.execute()
            self.user = result.user
            self.settings = result.settings
            self.isLoading = false
        }
    }
}

