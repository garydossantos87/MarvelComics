import Foundation

extension Character.Detail {
    final class ViewModel: CharacterDetailViewModelProtocol {
        weak var coordinator: BaseCoordinator?
        
        // MARK: - Init -
        
        init(coordinator: BaseCoordinator?) {
            self.coordinator = coordinator
        }
    }
}
