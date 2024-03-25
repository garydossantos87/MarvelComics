import Combine
import Foundation

public extension Home {
    final class ViewModel: HomeViewModelProtocol {
        weak var coordinator: BaseCoordinator?
        
        init(coordinator: BaseCoordinator?) {
            self.coordinator = coordinator
        }
    }
}
