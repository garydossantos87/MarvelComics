import UIKit

extension BaseCoordinator {
    func makeCharacterDetail(with apiClient: APIClientProtocol) -> UIViewController {
        let viewController =  Character.Detail.ViewFactory(
            with: apiClient,
            coordinator: self
        ).make()
        return viewController
    }
    
    func openCharacterDetail() {
        guard let viewController = currentFlowViewController(with: .characterDetail) else { return }
        handleNavigation(with: .push(viewController: viewController))
    }
}
