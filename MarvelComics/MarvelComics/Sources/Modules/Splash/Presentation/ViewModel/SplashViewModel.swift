import Combine
import Foundation

public extension Splash {
    final class ViewModel: SplashViewModelProtocol {
        weak var coordinator: BaseCoordinator?
        
        init(coordinator: BaseCoordinator?) {
            self.coordinator = coordinator
            
            // TODO: Call comic sevice here and pass the data to Home screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                coordinator?.openHome()
            }
        }
    }
}
