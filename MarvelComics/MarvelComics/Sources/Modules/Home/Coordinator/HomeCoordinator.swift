import UIKit

extension BaseCoordinator {
    // MARK: - Private methods -
    
    private func homeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        setupTabBarAppearance(with: tabBarController.tabBar)
        
        let homeViewFactory = Home.ViewFactory(with: self)
        let homeViewController = homeViewFactory.make()
            .embedded
            .withTabConfiguration(.comics)
        
        let viewController = UIViewController()
            .embedded
            .withTabConfiguration(.characters)
        viewController.view.backgroundColor = .blue
        
        tabBarController.setViewControllers([homeViewController, viewController], animated: true)
        return tabBarController
    }
    
    private func setupTabBarAppearance(with tabBar: UITabBar) {
        tabBar.tintColor = .primaryColor
        tabBar.unselectedItemTintColor = .tertiaryColor
        UITabBar.appearance().barTintColor = .primaryColor
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = .white
        tabAppearance.stackedLayoutAppearance.normal.iconColor = .gray
        tabAppearance.stackedLayoutAppearance.selected.iconColor = .primaryColor
        
        tabBar.standardAppearance = tabAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabAppearance
        }
    }
    
    // MARK: - Public methods -
    
    func makeHome() -> UIViewController {
        homeTabBarController()
    }
    
    func openHome() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.window?.rootViewController = setApplicationFlow(with: .home)
        appDelegate.window?.makeKeyAndVisible()
    }
}
