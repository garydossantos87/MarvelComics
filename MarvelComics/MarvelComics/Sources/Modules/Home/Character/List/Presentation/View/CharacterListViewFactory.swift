import UIKit

extension Character.List {
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

extension Character.List.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let repository = Character.Repository(client: apiClient)
        let useCases = UseCase.CharacterUseCases(with: repository)
        let viewModel = Character.List.ViewModel(
            coordinator: coordinator,
            useCases: useCases
        )
        return Character.List.ViewController(with: viewModel)
    }
}
