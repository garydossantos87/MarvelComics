import UIKit

extension BaseCoordinator {
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

        let comicListViewFactory = Comic.List.ViewFactory(with: self)
        let comicListViewController = comicListViewFactory.make()
            .embedded()
            .withTabConfiguration(.comics)

        let characterListViewFactory = Character.List.ViewFactory(with: self)
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
}
