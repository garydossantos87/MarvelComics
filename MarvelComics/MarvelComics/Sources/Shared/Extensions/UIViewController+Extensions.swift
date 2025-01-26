import UIKit

extension UIViewController {
    enum TabConfiguration {
        case comics
        case characters
        
        var title: String {
            switch self {
            case .comics: "Comics"
            case .characters: "Characters"
            }
        }
        
        var image: UIImage {
            switch self {
            case .comics: return .icnComics
            case .characters: return .icnCharacters
            }
        }
    }

    func hideTabBar() -> UINavigationController? {
        guard let navigationController = navigationController else { return nil }
        navigationController.tabBarController?.tabBar.isHidden = true
        return navigationController
    }

    func embedded(isNavigationBarHidden: Bool = true) -> UINavigationController {
        let navController = UINavigationController(rootViewController: self)
        navController.isNavigationBarHidden = isNavigationBarHidden
        return navController
    }
    
    func withTabConfiguration(_ config: TabConfiguration) -> UIViewController {
        tabBarItem?.image = config.image
        tabBarItem?.title = config.title
        return self
    }
}

