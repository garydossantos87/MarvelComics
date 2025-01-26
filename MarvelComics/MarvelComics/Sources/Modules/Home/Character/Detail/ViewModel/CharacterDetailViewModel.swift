import Foundation

extension Character.Detail {
    final class ViewModel: CharacterDetailViewModelProtocol, ObservableObject {
        var state: ViewModelState?
        var coordinator: BaseCoordinator?

        // MARK: - Init -
        
        init(coordinator: BaseCoordinator?) {
            self.coordinator = coordinator
        }
    }
}


extension Character.Detail.ViewModel {
    func goBack() {
        coordinator?.handleNavigation(with: .pop)
    }
}
