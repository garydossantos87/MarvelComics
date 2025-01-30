import Foundation

extension UseCase {
    struct SerieUseCases {
        let fetchSeries: UseCase.FetchSeriesUseCase

        // MARK: - Init -

        init(with repository: SerieRepositoryProtocol) {
            self.fetchSeries = UseCase.FetchSeriesUseCase(repository: repository)
        }
    }
}
