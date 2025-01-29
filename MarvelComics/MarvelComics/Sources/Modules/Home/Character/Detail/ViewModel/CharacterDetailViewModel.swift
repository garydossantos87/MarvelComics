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
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let model = Character.List.Model(id: 1, name: "Character Name")
            self.state = .success(model)
        }
    }

    func onBackButtonClicked() {
        coordinator?.openCharacterList()
    }
}
