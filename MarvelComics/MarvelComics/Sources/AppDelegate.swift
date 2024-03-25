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
        coordinator = .init()
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    private func start() {
        window?.rootViewController = coordinator?.setApplicationFlow(with: .splash)
        window?.makeKeyAndVisible()
    }
}
