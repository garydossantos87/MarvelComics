import UIKit

public extension Splash {
    struct ViewFactory {
        private let coordinator: BaseCoordinator

        // MARK: - Init -
        
        init(with coordinator: BaseCoordinator) {
            self.coordinator = coordinator
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
