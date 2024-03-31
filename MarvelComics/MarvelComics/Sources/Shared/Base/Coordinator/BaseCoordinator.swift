import UIKit

final class BaseCoordinator {
    private var navigationController: UINavigationController
    private let apiClient: APIClientProtocol
    
    // MARK: - Init -
    
    init(apiClient: APIClientProtocol) {
        navigationController = .init()
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods -
    
    // MARK: - Handle All Navigation Styles -
    
    public func handleNavigation(with navigation: CoordinatorNavigation) {
        switch navigation {
        case .push(let viewController):
            self.navigationController.pushViewController(viewController, animated: true)
        case .pop:
            self.navigationController.popViewController(animated: true)
        case .dissmiss:
            guard let presentedViewController = navigationController.presentedViewController else {
                self.navigationController.topViewController?.dismiss(animated: true)
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
    
    public func setApplicationFlow(with flow: CoordinatorFlow) -> UINavigationController? {
        navigationController.viewControllers.removeAll()
        navigationController = UINavigationController(rootViewController: currentFlowViewController(with: flow) ?? UIViewController())
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    // MARK: - Private methods -
    
    private func currentFlowViewController(with flow: CoordinatorFlow) -> UIViewController? {
        switch flow {
        case .splash:
            return makeSplash(with: apiClient)
        case .home:
            return makeHome(with: apiClient)
        default: break
        }
        return UIViewController()
    }
}
