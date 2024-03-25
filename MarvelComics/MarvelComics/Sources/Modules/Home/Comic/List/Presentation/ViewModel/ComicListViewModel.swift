import Foundation

extension Comic.List {
    final class ViewModel: ComicListViewModelProtocol {
        weak var coordinator: BaseCoordinator?
        
        init(coordinator: BaseCoordinator?) {
            self.coordinator = coordinator
        }
        
    }
}
