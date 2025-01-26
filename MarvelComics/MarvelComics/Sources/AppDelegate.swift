import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: BaseCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        start()
        return true
    }
    
    // MARK: - Private methods -
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = BaseCoordinator()
    }
    
    private func start() {
        window?.rootViewController = coordinator?.setApplicationFlow(with: makeSplash())
        window?.makeKeyAndVisible()
    }

    private func makeSplash() -> UIViewController {
        guard let coordinator = coordinator else { return UIViewController() }
        return Splash.ViewFactory(with: coordinator)
            .make()
    }
}
