import Combine

extension Comic.List {
    final class ViewModel: ComicListViewModelProtocol {
        weak var coordinator: BaseCoordinator?
        private let repository: Comic.Repository
        private var cancellables: [AnyCancellable] = []
        
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
        // need tp inject repository
        repository.fetchComics()
            .sink(receiveCompletion: { [weak self] complete in
                switch complete {
                case .finished: break
                case .failure(let error):
                    print("** Error VM \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] comics in
                print("** Receive VM \(comics.data)")
            }).store(in: &cancellables)
    }
}
