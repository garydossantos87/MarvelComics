import Combine

extension Story {
    struct Repository: RepositoryProtocol {
        var client: APIClientProtocol
        
        // MARK: - Init -
        
        init(client: APIClientProtocol = API.DefaultClient.shared) {
            self.client = client
        }
    }
}

// MARK: - Protocol methods -

extension Story.Repository: StoryRepositoryProtocol {
    func fetchStories(with comicId: Int) -> AnyPublisher<Story.ListResult, API.NetworkError> {
        let request = Story.ListRequest(comicId: comicId)
        return client.request(request)
    }
}
