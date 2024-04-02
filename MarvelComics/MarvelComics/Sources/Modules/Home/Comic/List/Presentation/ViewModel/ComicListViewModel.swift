import Combine

extension Comic.List {
    final class ViewModel: ComicListViewModelProtocol {        
        weak var coordinator: BaseCoordinator?
        private let repository: Comic.Repository
        private var comics: [Comic.List.Model]?
        private var cancellables: [AnyCancellable] = []
        var showData : (()->())?
        
         init(coordinator: BaseCoordinator?, repository: Comic.Repository) {
            self.coordinator = coordinator
             self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension Comic.List.ViewModel {
    func viewDidLoad() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        repository.fetchComics()
            .sink(receiveCompletion: { [weak self] complete in
                switch complete {
                case .finished: break
                case .failure(let error):
                    print("** Error VM \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] comicsDTO in
                self?.comics = comicsDTO.data.results.map { Comic.List.Model(with: $0) }
                self?.showData?()
            }).store(in: &cancellables)
    }
    
    func comicModel(at index: Int) -> Comic.List.Model? {
        guard let comics, index < comics.count else { return nil }
        return comics[index]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let comics else { return 0 }
        return comics.count
    }
    
    func numberOfSections() -> Int {
        return Comic.List.View.Constants.numbersOfSections
    }
}
