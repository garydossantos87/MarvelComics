import Combine

protocol StoryRepositoryProtocol {
    func fetchStories(with comicId: Int) -> AnyPublisher<Story.ListResult, API.NetworkError>
}
