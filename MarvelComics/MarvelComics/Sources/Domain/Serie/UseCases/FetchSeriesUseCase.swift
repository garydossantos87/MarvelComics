import Foundation
import Combine

extension UseCase {
    struct FetchSeriesUseCase: FetchSeriesUseCaseProtocol {
        private let repository: SerieRepositoryProtocol

        // MARK: - Init -

        init(repository: SerieRepositoryProtocol) {
            self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension UseCase.FetchSeriesUseCase {
    typealias Input = Int
    typealias Output = AnyPublisher<[Serie.List.Model], ErrorModel>

    func execute(input: Int) -> Output {
        repository.fetchSeries(with: input)
            .map { $0.data.results.map(Serie.List.Model.init) }
            .mapToDomainError()
            .eraseToAnyPublisher()
    }
}
