import UIKit

extension BaseCoordinator {
    func makeSplash(with apiClient: APIClientProtocol) -> UIViewController {
        let splashViewFactory = Splash.ViewFactory(with: apiClient, coordinator: self)
        let splashViewController = splashViewFactory.make()
        return splashViewController
    }
}
