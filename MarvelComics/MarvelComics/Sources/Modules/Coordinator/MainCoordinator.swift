import UIKit

final class MainCoordinator {
    //MARK: - Init
    private let window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
}

//MARK: - Protocol methods

extension MainCoordinator: Coordinator {
    func start() {
        let splashViewFactory = Splash.ViewFactory()
        let splashViewController = splashViewFactory.make()
        let navController = UINavigationController(rootViewController: splashViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
