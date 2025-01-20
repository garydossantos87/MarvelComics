import Combine
import Foundation

extension Comic.List {
    final class ViewModel: ComicListViewModelProtocol {
        @Published var result: Result<Void, Error>?
        weak var coordinator: BaseCoordinator?
        private let repository: ComicRepositoryProtocol
        private var comics: [Comic.List.Model]?
        private var cancellables: Set<AnyCancellable> = []

        // MARK: - Init -

        init(coordinator: BaseCoordinator?, repository: ComicRepositoryProtocol) {
            self.coordinator = coordinator
            self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension Comic.List.ViewModel {
    func viewDidLoad() {
        cancellables.cancelAll()
        repository.fetchComics()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] complete in
                switch complete {
                case .finished: break
                case .failure(let error):
                    self?.result = .failure(error)
                }
            }, receiveValue: { [weak self] comicsDTO in
                self?.comics = comicsDTO.data.results.map { Comic.List.Model(with: $0) }
                self?.result = .success(())
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
