import UIKit

final class CharacterListCoordinator: BaseCoordinator, CharacterListCoordinatorProtocol {
    func openCharacterDetail() {
        guard let navigationController = navigationController else { return }
        let characterDetailVC = makeCharacterDetail(with: navigationController)
        handleNavigation(with: .push(viewController: characterDetailVC))
    }

    // MARK: - Private methods -

    private func makeCharacterDetail(with navigationController: UINavigationController?) -> UIViewController {
        let coordinator = CharacterDetailCoordinator(with: navigationController)
        return Character.Detail.ViewFactory(with: coordinator)
            .make()
    }
}
