import Foundation

extension UseCase {
    struct ComicDetailUseCases {
        let fetchCreators: UseCase.FetchCreatorsUseCase
        let fetchStories: UseCase.FetchStoriesUseCase
        let fetchCharacters: UseCase.FetchCharacterFromComicUseCase

        // MARK: - Init -

        init(
            with creatorRepository: CreatorRepositoryProtocol,
            storyRepository: StoryRepositoryProtocol,
            characterRepository: CharacterRepositoryProtocol
        ) {
            self.fetchCreators = UseCase.FetchCreatorsUseCase(repository: creatorRepository)
            self.fetchStories = UseCase.FetchStoriesUseCase(repository: storyRepository)
            self.fetchCharacters = UseCase.FetchCharacterFromComicUseCase(repository: characterRepository)
        }
    }
}
