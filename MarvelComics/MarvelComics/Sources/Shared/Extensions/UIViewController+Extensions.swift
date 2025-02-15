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
        
        var accessabilityIdentifier: String {
            switch self {
            case .comics: return AccessibilityIdentifiers.Comic.tabBarItemID
            case .characters: return AccessibilityIdentifiers.Character.tabBarItemID
            }
        }
    }

    func withTabConfiguration(_ config: TabConfiguration) -> UIViewController {
        tabBarItem?.image = config.image
        tabBarItem?.title = config.title
        tabBarItem?.accessibilityIdentifier = config.accessabilityIdentifier
        return self
    }
}
