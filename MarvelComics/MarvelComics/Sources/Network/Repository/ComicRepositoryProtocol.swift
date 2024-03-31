import Combine

//typealias FetchComicsResult = (ComicListResult, Error) -> ()

protocol ComicRepositoryProtocol {
    func fetchComics() -> AnyPublisher<Comic.ListResult, Error>
}
