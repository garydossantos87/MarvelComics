import Combine
import Foundation

public extension Splash {
    final class ViewModel: SplashViewModelProtocol {
        var state: ViewModelState?
        var coordinator: SplashCoordinator?
        
        init(coordinator: SplashCoordinator?) {
            self.coordinator = coordinator
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                coordinator?.openHome()
            }
        }
    }
}
