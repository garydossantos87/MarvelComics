import Combine

protocol CreatorRepositoryProtocol {
    func fetchCreators(with comicId: Int) -> AnyPublisher<Creator.ListResult, API.NetworkError>
}
