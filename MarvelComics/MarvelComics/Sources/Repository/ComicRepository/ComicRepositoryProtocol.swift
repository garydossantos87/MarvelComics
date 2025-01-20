import Combine

protocol ComicRepositoryProtocol {
    func fetchComics() -> AnyPublisher<Comic.ListResult, API.NetworkError>
}
