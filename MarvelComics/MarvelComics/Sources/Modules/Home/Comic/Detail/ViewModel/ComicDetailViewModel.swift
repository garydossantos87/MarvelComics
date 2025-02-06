import Foundation
import Combine

extension Comic.Detail {
    final class ViewModel: ComicDetailViewModelProtocol, ObservableObject {
        @Published var state: ViewModelState?
        var coordinator: ComicDetailCoordinator?
        private let useCases: UseCase.ComicDetailUseCases
        private var comicDetail: Comic.Detail.Model
        private var cancellables: Set<AnyCancellable> = []

        // MARK: - Init -

        init(
            coordinator: ComicDetailCoordinator?,
            useCases: UseCase.ComicDetailUseCases,
            comic: Comic.List.Model? = nil
        ) {
            self.coordinator = coordinator
            self.useCases = useCases
            comicDetail = .init(comic: comic)
        }
    }
}

// MARK: - Protocol methods -

extension Comic.Detail.ViewModel {
    func onAppear() {
        cancellables.cancelAll()
        state = .loading
        guard let comic = comicDetail.comic else { return }

        let creatorsPublisher = useCases.fetchCreators.execute(input: comic.id)
        let storiesPublisher = useCases.fetchStories.execute(input: comic.id)
        let charactersPublisher = useCases.fetchCharacters.execute(input: comic.id)

        Publishers.CombineLatest3(
            creatorsPublisher,
            storiesPublisher,
            charactersPublisher
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] complete in
            guard let self else { return }
            switch complete {
            case .finished: break
            case .failure(let error):
                self.state = .failure(error)
            }
        }, receiveValue: { [weak self] (
            creators: [Creator.List.Model],
            stories: [Story.List.Model],
            characters: [Character.List.Model]) in
            guard let self else { return }
            self.comicDetail = Comic.Detail.Model(
                comic: comic,
                creators: creators,
                stories: stories,
                characters: characters
            )
            self.state = .success(comicDetail)
        }).store(in: &cancellables)
    }

    func onBackButtonClicked() {
        coordinator?.openComicList()
    }
}
