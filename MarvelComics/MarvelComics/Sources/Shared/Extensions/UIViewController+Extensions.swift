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

    func withTabConfiguration(_ config: TabConfiguration) -> UIViewController {
        tabBarItem?.image = config.image
        tabBarItem?.title = config.title
        return self
    }
}
