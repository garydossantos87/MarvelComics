import Foundation
import Combine

extension UseCase {
    struct FetchCreatorsUseCase: FetchCreatorsUseCaseProtocol {
        private let repository: CreatorRepositoryProtocol

        // MARK: - Init -

        init(repository: CreatorRepositoryProtocol) {
            self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension UseCase.FetchCreatorsUseCase {
    typealias Input = Int
    typealias Output = AnyPublisher<[Creator.List.Model], ErrorModel>

    func execute(input: Int) -> Output {
        repository.fetchCreators(with: input)
            .map { $0.data.results.map(Creator.List.Model.init) }
            .mapToDomainError()
            .eraseToAnyPublisher()
    }
}
