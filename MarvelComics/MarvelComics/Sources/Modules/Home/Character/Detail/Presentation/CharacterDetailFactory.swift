import UIKit

extension Character.Detail {
    struct ViewFactory {
        private let coordinator: BaseCoordinator
        private let apiClient: APIClientProtocol
        
        // MARK: - Init -
        
        init(with apiClient: APIClientProtocol, coordinator: BaseCoordinator) {
            self.apiClient = apiClient
            self.coordinator = coordinator
        }
    }
}

// MARK: - Protocol metods

extension Character.Detail.ViewFactory: ViewFactory {
    func make() -> UIViewController {
//        let repository = Character.Repository(client: apiClient)
        let viewModel = Character.Detail.ViewModel(coordinator: coordinator)
        return Character.Detail.ViewController(with: viewModel)
    }
}
