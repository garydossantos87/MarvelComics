import Foundation

extension Character.Detail {
    final class ViewModel: CharacterDetailViewModelProtocol, ObservableObject {
        var state: ViewModelState?
        var coordinator: CharacterDetailCoordinator?

        // MARK: - Init -
        
        init(coordinator: CharacterDetailCoordinator?) {
            self.coordinator = coordinator
        }
    }
}

// MARK: - Protocol methods -

extension Character.Detail.ViewModel {
    func onBackButtonClicked() {
        coordinator?.openCharacterList()
    }
}
