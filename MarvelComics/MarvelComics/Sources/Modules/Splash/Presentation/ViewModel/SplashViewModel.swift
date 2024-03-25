import Combine
import Foundation

public extension Splash {
    final class ViewModel: SplashViewModelProtocol {
        weak var coordinator: BaseCoordinator?
        
        init(coordinator: BaseCoordinator?) {
            self.coordinator = coordinator
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                coordinator?.openHome()
            }
        }
    }
}
