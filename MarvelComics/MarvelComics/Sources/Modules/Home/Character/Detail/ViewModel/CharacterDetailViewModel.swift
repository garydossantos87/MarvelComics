import Foundation

extension Character.Detail {
    final class ViewModel: CharacterDetailViewModelProtocol {
        var state: ViewModelState?
        weak var coordinator: BaseCoordinator?
        
        // MARK: - Init -
        
        init(coordinator: BaseCoordinator?) {
            self.coordinator = coordinator
        }
    }
}
