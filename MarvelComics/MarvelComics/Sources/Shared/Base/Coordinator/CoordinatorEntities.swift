import UIKit

// MARK: - CoordinatorNavigation

enum CoordinatorNavigation {
    case push(viewController: UIViewController)
    case pop
    case dissmiss
    case present(controller: UIViewController, presentationStyle: UIModalPresentationStyle)
}

// MARK: - ApplicationFlow

enum CoordinatorFlow {
    case splash
    case home
    case comicDetail
    case characterDetail
}
