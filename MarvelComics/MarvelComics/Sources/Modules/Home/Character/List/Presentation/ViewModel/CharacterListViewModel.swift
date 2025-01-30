import Combine
import UIKit
import Foundation

extension Character.List {
    final class ViewModel: CharacterListViewModelProtocol {
        @Published var state: ViewModelState?
        private let useCases: UseCase.CharacterUseCases
        private var charactersPagination: Character.PaginationModel?
        private var cancellables: Set<AnyCancellable> = []
        private var isFetchingData: Bool = false
        var coordinator: CharacterListCoordinator?

        // MARK: - Init -

        init(
            coordinator: CharacterListCoordinator?,
            useCases: UseCase.CharacterUseCases
        ) {
            self.coordinator = coordinator
            self.useCases = useCases
        }
    }


}

// MARK: - Protocol methods -

extension Character.List.ViewModel {
    func viewDidLoad() {
        loadData()
    }

    func numberOfRowsInSection(section: Int) -> Int {
        guard let characters = charactersPagination?.results else { return 0 }
        return characters.count
    }

    func characterModel(at index: Int) -> Character.List.Model? {
        guard let characters = charactersPagination?.results,
              characters.indices.contains(index) else {
            return nil
        }
        return characters[index]
    }

    func onCharacterClicked(at index: Int) {
        guard let characters = charactersPagination?.results,
              characters.indices.contains(index) else {
            return
        }
        coordinator?.openCharacterDetail(with: characters[index])
    }

    func loadData() {
        guard !isFetchingData else { return }
        cancellables.cancelAll()
        isFetchingData = true
        state = .loading
        useCases.fetchCharacters.execute(input: charactersPagination?.offset)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] complete in
                guard let self else { return }
                switch complete {
                case .finished: break
                case .failure(let error):
                    self.isFetchingData = false
                    self.state = .failure(error)
                }
            }, receiveValue: { [weak self] newCharactersPagination in
                guard let self else { return }
                self.isFetchingData = false
                self.charactersPagination = Character.PaginationModel(
                    with: newCharactersPagination,
                    oldCharacters: charactersPagination?.results
                )
                self.state = .success()
            }).store(in: &cancellables)
    }
}
