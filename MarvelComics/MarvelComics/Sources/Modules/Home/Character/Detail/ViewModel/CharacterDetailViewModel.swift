import Foundation
import Combine

extension Character.Detail {
    final class ViewModel: CharacterDetailViewModelProtocol, ObservableObject {
        @Published var state: ViewModelState?
        var coordinator: CharacterDetailCoordinator?
        private let useCases: UseCase.SerieUseCases
        private var characterDetail: Character.Detail.Model
        private var series: [Serie.List.Model]?
        private var cancellables: Set<AnyCancellable> = []

        // MARK: - Init -

        init(
            coordinator: CharacterDetailCoordinator?,
            useCases: UseCase.SerieUseCases,
            character: Character.List.Model? = nil
        ) {
            self.coordinator = coordinator
            self.useCases = useCases
            characterDetail = .init(character: character)
        }
    }
}

// MARK: - Protocol methods -

extension Character.Detail.ViewModel {
    func onAppear() {
        cancellables.cancelAll()
        state = .loading
        guard let character = characterDetail.character else { return }
        useCases.fetchSeries.execute(input: character.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] complete in
                guard let self else { return }
                switch complete {
                case .finished: break
                case .failure(let error):
                    self.state = .failure(error)
                }
            }, receiveValue: { [weak self] series in
                guard let self else { return }
                self.characterDetail = Character.Detail.Model(
                    character: character,
                    series: series
                )
                self.state = .success(characterDetail)
            }).store(in: &cancellables)
    }

    func onBackButtonClicked() {
        coordinator?.openCharacterList()
    }
}
