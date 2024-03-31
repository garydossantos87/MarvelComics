import UIKit

extension BaseCoordinator {
    // MARK: - Private methods -
    
    private func homeTabBarController(with apiClient: APIClientProtocol) -> UITabBarController {
        let tabBarController = UITabBarController()
        setupTabBarAppearance(with: tabBarController.tabBar)
        
        let comicListViewFactory = Comic.List.ViewFactory(with: apiClient, coordinator: self)
        let comicListViewController = comicListViewFactory.make()
            .embedded()
            .withTabConfiguration(.comics)
        
        let characterListViewFactory = Character.List.ViewFactory(with: apiClient, coordinator: self)
        let CharacterListViewController = characterListViewFactory.make()
            .embedded()
            .withTabConfiguration(.characters)
        
        tabBarController.setViewControllers([comicListViewController, CharacterListViewController], animated: true)
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
    
    func makeHome(with apiClient: APIClientProtocol) -> UIViewController {
        homeTabBarController(with: apiClient)
    }
    
    func openHome() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.window?.rootViewController = setApplicationFlow(with: .home)
        appDelegate.window?.makeKeyAndVisible()
    }
}
