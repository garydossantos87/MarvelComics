import Combine
import UIKit
import Foundation

extension Character.List {
    final class ViewModel: CharacterListViewModelProtocol {
        @Published var state: ViewModelState?
        private let useCases: UseCase.CharacterUseCases
        private var charactersPagination: Character.PaginationModel?
        private var filteredCharacters: [Character.List.Model] = []
        private var cancellables: Set<AnyCancellable> = []
        private var isFetchingData: Bool = false
        private var isFilteringData: Bool = false
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
        return isFilteringData ? filteredCharacters.count :
        charactersPagination?.results.count ?? .zero
    }

    func characterModel(at index: Int) -> Character.List.Model? {
        let source = isFilteringData ? filteredCharacters : charactersPagination?.results
        guard let characters = source, characters.indices.contains(index) else { return nil }
        return characters[index]
    }

    func onCharacterClicked(at index: Int) {
        let source = isFilteringData ? filteredCharacters : charactersPagination?.results
        guard let characters = source, characters.indices.contains(index) else { return }
        coordinator?.openCharacterDetail(with: characters[index])
    }

    func loadData() {
        guard !isFetchingData && !isFilteringData else { return }
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
    
    func onFilterCharacters(with query: String?) {
        guard let query = query, !query.isEmpty else {
            isFilteringData = false
            state = .success()
            return
        }
        
        isFilteringData = true
        filteredCharacters = charactersPagination?.results.filter { character in
            character.name.lowercased().contains(query.lowercased())
        } ?? []
        state = .success()
    }
}
