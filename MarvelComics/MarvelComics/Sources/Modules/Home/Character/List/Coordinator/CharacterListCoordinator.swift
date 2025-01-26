import UIKit

extension BaseCoordinator {
    // MARK: - Public methods -

    func openCharacterDetail() {
        let characterDetailVC = makeCharacterDetail()
        handleNavigation(with: .push(viewController: characterDetailVC))
    }

    // MARK: - Private methods -

    private func makeCharacterDetail() -> UIViewController {
        Character.Detail.ViewFactory(with: self)
            .make()
    }
}

