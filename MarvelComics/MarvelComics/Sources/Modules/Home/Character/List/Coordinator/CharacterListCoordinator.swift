import UIKit

final class CharacterListCoordinator: BaseCoordinator, CharacterListCoordinatorProtocol {
    func openCharacterDetail(with character: Character.List.Model) {
        guard let navigationController = navigationController else { return }
        let characterDetailVC = makeCharacterDetail(
            with: navigationController,
            character: character
        )
        handleNavigation(with: .push(viewController: characterDetailVC))
    }
    
    // MARK: - Private methods -
    
    private func makeCharacterDetail(
        with navigationController: UINavigationController?,
        character: Character.List.Model
    ) -> UIViewController {
        let coordinator = CharacterDetailCoordinator(with: navigationController)
        return Character.Detail.ViewFactory(
            with: coordinator,
            character: character
        )
        .make()
    }
}
