import UIKit

public extension Splash {
    struct ViewFactory {
        private let coordinator: BaseCoordinator
        private let apiClient: APIClientProtocol
        
        // MARK: - Init -
        
        init(with apiClient: APIClientProtocol, coordinator: BaseCoordinator) {
            self.coordinator = coordinator
            self.apiClient = apiClient
        }
    }
}

//MARK: - Protocol methods -

extension Splash.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let viewModel = Splash.ViewModel(coordinator: coordinator)
        return Splash.ViewController(with: viewModel)
    }
}
