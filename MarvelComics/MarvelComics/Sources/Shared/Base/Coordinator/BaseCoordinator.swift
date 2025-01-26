import UIKit

class BaseCoordinator: BaseCoordinatorProtocol {
    var navigationController: UINavigationController?

    // MARK: - Init -
    
    init(with navigationController: UINavigationController? = .init()) {
        self.navigationController = navigationController ?? .init()
    }
    
    // MARK: - Public methods -
    
    // MARK: - Handle All Navigation Styles -
    
    public func handleNavigation(with navigation: CoordinatorNavigation) {
        guard let navigationController else { return }
        switch navigation {
        case .push(let viewController):
            navigationController.pushViewController(viewController, animated: true)
        case .pop:
            navigationController.popViewController(animated: true)
        case .dissmiss:
            guard let presentedViewController = navigationController.presentedViewController else {
                navigationController.topViewController?.dismiss(animated: true)
                return
            }
            presentedViewController.dismiss(animated: true, completion: nil)
        case .present(let controller, let presentationStyle):
            guard let presentedViewController = navigationController.presentedViewController else {
                navigationController.topViewController?.present(
                    controller,
                    animated: true,
                    completion: nil
                )
                return
            }
            presentedViewController.modalPresentationStyle = presentationStyle
            presentedViewController.present(controller, animated: true)
        }
    }
    
    public func setApplicationFlow(with viewController: UIViewController) -> UINavigationController? {
        navigationController?.viewControllers.removeAll()
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.isNavigationBarHidden = true
        return navigationController
    }
}
