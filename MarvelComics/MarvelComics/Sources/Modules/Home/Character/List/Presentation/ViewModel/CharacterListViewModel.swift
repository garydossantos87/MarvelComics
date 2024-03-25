import Foundation

extension Character.List {
    final class ViewModel: CharacterListViewModelProtocol {
        weak var coordinator: BaseCoordinator?
        
        init(coordinator: BaseCoordinator?) {
            self.coordinator = coordinator
        }
        
    }
}
