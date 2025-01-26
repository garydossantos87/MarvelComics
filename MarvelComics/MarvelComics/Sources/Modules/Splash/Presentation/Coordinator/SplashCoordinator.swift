import UIKit

final class SplashCoordinator: BaseCoordinator, SplashCoordinatorProtocol {
    // MARK: - Public methods -

    func openHome() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.window?.rootViewController = setApplicationFlow(with: makeHome())
        appDelegate.window?.makeKeyAndVisible()
    }

    // MARK: - Private methods -

    private func makeHome() -> UITabBarController {
        let tabBarController = UITabBarController()
        setupTabBarAppearance(with: tabBarController.tabBar)

        tabBarController.setViewControllers([
            comicNavigationController(),
            characterNavigationController()], animated: true
        )
        return tabBarController
    }

    private func characterNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        let coordinatorList = CharacterListCoordinator(with: navController)
        let characterListViewFactory = Character.List.ViewFactory(with: coordinatorList)
        let characterListViewController = characterListViewFactory.make()
            .withTabConfiguration(.characters)
        navController.setViewControllers([characterListViewController], animated: true)
        return navController
    }

    private func comicNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        let coordinatorList = ComicListCoordinator(with: navController)
        let comicListViewFactory = Comic.List.ViewFactory(with: coordinatorList)
        let comicListViewController = comicListViewFactory.make()
            .withTabConfiguration(.comics)
        navController.setViewControllers([comicListViewController], animated: true)
        return navController
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
}
