import Combine

extension Character.List {
    final class ViewModel: CharacterListViewModelProtocol {
        private let repository: CharacterRepositoryProtocol
        private var dataCharacters: Character.PaginationModel?
        private var cancellables: [AnyCancellable] = []
        private var isFetchingData: Bool = false
        weak var coordinator: BaseCoordinator?
        var showData: (() -> ())?
        var showError: ((String) -> ())?
        
        // MARK: - Init -
        
        init(coordinator: BaseCoordinator?, repository: CharacterRepositoryProtocol) {
            self.coordinator = coordinator
            self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension Character.List.ViewModel {
    func loadData() {
        guard !isFetchingData else { return }
        isFetchingData = true
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        repository.fetchCharacters(with: dataCharacters?.offset)
            .sink(receiveCompletion: { [weak self] complete in
                switch complete {
                case .finished: break
                case .failure(let error):
                    self?.isFetchingData = false
                    self?.showError?(error.name)
                }
            }, receiveValue: { [weak self] charactersDTO in
                guard let self else { return }
                self.isFetchingData = false
                self.dataCharacters = Character.PaginationModel(with: charactersDTO, oldCharacters: self.dataCharacters?.results)
                self.showData?()
            }).store(in: &cancellables)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let characters = dataCharacters?.results else { return 0 }
        return characters.count
    }
    
    func characterModel(at index: Int) -> Character.List.Model? {
        guard let characters = dataCharacters?.results, index < characters.count else { return nil }
        return characters[index]
    }
    
    func onCharacterClicked(position: Int) {
        coordinator?.openCharacterDetail()
    }
}
