import UIKit

extension Comic.List {
    struct ViewFactory {
        private let coordinator: BaseCoordinator

        // MARK: - Init -
        
        init(with coordinator: BaseCoordinator) {
            self.coordinator = coordinator
        }
    }
}

// MARK: - Protocol metods

extension Comic.List.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let repository = Comic.Repository(client: API.DefaultClient.shared)
        let useCases = UseCase.ComicUseCases(with: repository)
        let viewModel = Comic.List.ViewModel(
            coordinator: coordinator,
            useCases: useCases
        )
        return Comic.List.ViewController(with: viewModel)
    }
}
