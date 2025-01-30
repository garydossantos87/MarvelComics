import Combine

protocol SerieRepositoryProtocol {
    func fetchSeries(with characterId: Int) -> AnyPublisher<Serie.ListResult, API.NetworkError>
}
