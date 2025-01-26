import UIKit

public extension Splash {
    struct ViewFactory {
        private let coordinator: SplashCoordinator

        // MARK: - Init -
        
        init(with coordinator: SplashCoordinator) {
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
