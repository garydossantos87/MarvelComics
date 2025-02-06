import Foundation
import Combine

extension UseCase {
    struct FetchStoriesUseCase: FetchStoriesUseCaseProtocol {
        private let repository: StoryRepositoryProtocol

        // MARK: - Init -

        init(repository: StoryRepositoryProtocol) {
            self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension UseCase.FetchStoriesUseCase {
    typealias Input = Int
    typealias Output = AnyPublisher<[Story.List.Model], ErrorModel>

    func execute(input: Int) -> Output {
        repository.fetchStories(with: input)
            .map { $0.data.results.map(Story.List.Model.init) }
            .mapToDomainError()
            .eraseToAnyPublisher()
    }
}
