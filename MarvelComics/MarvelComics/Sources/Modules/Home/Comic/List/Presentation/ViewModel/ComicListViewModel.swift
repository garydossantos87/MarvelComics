import Combine
import Foundation

extension Comic.List {
    final class ViewModel: ComicListViewModelProtocol {
        @Published var state: ViewModelState?
        var coordinator: ComicListCoordinator?
        private let useCases: UseCase.ComicUseCases
        private var comics: [Comic.List.Model]?
        private var cancellables: Set<AnyCancellable> = []

        // MARK: - Init -

        init(
            coordinator: ComicListCoordinator?,
            useCases: UseCase.ComicUseCases
        ) {
            self.coordinator = coordinator
            self.useCases = useCases
        }
    }
}

// MARK: - Protocol methods -

extension Comic.List.ViewModel {
    func viewDidLoad() {
        cancellables.cancelAll()
        state = .loading
        useCases.fetchComics.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] complete in
                guard let self else { return }
                switch complete {
                case .finished: break
                case .failure(let error):
                    self.state = .failure(error)
                }
            }, receiveValue: { [weak self] comics in
                guard let self else { return }
                self.comics = comics
                self.state = .success()
            }).store(in: &cancellables)
    }

    func comicModel(at index: Int) -> Comic.List.Model? {
        guard let comics, index < comics.count else { return nil }
        return comics[index]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let comics else { return .zero }
        return comics.count
    }

    func numberOfSections() -> Int {
        return Comic.List.View.Constants.numbersOfSections
    }
}
