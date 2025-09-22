import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var welcomeMessage: String = "Loading..."
    
    private let getHomeDataUseCase: GetHomeDataUseCase

    init(getHomeDataUseCase: GetHomeDataUseCase) {
        self.getHomeDataUseCase = getHomeDataUseCase
    }
    
    func onAppear() {
        Task {
            // The ViewModel calls the Use Case to perform the business logic.
            // It knows nothing about where the data comes from.
            self.welcomeMessage = await getHomeDataUseCase.execute()
        }
    }
}

