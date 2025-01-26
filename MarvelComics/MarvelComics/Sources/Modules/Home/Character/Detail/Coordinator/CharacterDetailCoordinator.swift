import UIKit

protocol CharacterDetailCoordinatorProtocol: BaseCoordinatorProtocol {
    func openCharacterList()
}

final class CharacterDetailCoordinator: BaseCoordinator, CharacterDetailCoordinatorProtocol {
    func openCharacterList() {
        handleNavigation(with: .pop)
    }
}
