import UIKit

extension Comic.List {
    struct ViewFactory {
        private let coordinator: BaseCoordinator
        
        // MARK: - Init
        
        init(with coordinator: BaseCoordinator) {
            self.coordinator = coordinator
        }
    }
}

// MARK: - Protocol metods

extension Comic.List.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let viewModel = Comic.List.ViewModel(coordinator: coordinator)
        return Comic.List.ViewController(with: viewModel)
    }
}
