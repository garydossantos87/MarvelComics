import Combine

extension Character.List {
    final class ViewModel: CharacterListViewModelProtocol {
        private let repository: CharacterRepositoryProtocol
        private var characters: [Character.List.Model]?
        private var cancellables: [AnyCancellable] = []
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
    func viewDidLoad() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        repository.fetchCharacters()
            .sink(receiveCompletion: { [weak self] complete in
                switch complete {
                case .finished: break
                case .failure(let error):
                    self?.showError?(error.name)
                }
            }, receiveValue: { [weak self] charactersDTO in
                self?.characters = charactersDTO.data.results.map { Character.List.Model(with: $0) }
                self?.showData?()
            }).store(in: &cancellables)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let characters else { return 0 }
        return characters.count
    }
    
    func characterModel(at index: Int) -> Character.List.Model? {
        guard let characters, index < characters.count else { return nil }
        return characters[index]
    }
}
