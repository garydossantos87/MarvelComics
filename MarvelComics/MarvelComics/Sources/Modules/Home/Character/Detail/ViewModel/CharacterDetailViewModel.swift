import Foundation

extension Character.Detail {
    final class ViewModel: CharacterDetailViewModelProtocol, ObservableObject {
        @Published var state: ViewModelState?
        var coordinator: CharacterDetailCoordinator?

        // MARK: - Init -

        init(coordinator: CharacterDetailCoordinator?) {
            self.coordinator = coordinator
        }
    }
}

// MARK: - Protocol methods -

extension Character.Detail.ViewModel {
    func onAppear() {
        state = .loading
        print("State set to .loading")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.state = .success
            print("State set to .success")
        }
    }

    func onBackButtonClicked() {
        coordinator?.openCharacterList()
    }
}
