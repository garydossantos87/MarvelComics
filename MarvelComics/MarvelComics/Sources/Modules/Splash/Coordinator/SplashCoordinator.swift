import UIKit

extension BaseCoordinator {
    func makeSplash() -> UIViewController {
        let splashViewFactory = Splash.ViewFactory(with: self)
        let splashViewController = splashViewFactory.make()
        return splashViewController
    }
}
