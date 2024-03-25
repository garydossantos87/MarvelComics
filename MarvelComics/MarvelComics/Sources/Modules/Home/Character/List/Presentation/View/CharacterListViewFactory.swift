import UIKit

extension Character.List {
    struct ViewFactory {
        private let coordinator: BaseCoordinator
        
        // MARK: - Init
        
        init(with coordinator: BaseCoordinator) {
            self.coordinator = coordinator
        }
    }
}

// MARK: - Protocol metods

extension Character.List.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let viewModel = Character.List.ViewModel(coordinator: coordinator)
        return Character.List.ViewController(with: viewModel)
    }
}
