import UIKit

extension Comic.List {
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

extension Comic.List.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let repository = Comic.Repository(client: apiClient)
        let useCases = UseCase.ComicUseCases(repository: repository)
        let viewModel = Comic.List.ViewModel(coordinator: coordinator, useCases: useCases)
        return Comic.List.ViewController(with: viewModel)
    }
}
