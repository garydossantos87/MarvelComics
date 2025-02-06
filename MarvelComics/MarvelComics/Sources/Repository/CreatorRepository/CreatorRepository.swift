import Combine

extension Creator {
    struct Repository: RepositoryProtocol {
        var client: APIClientProtocol
        
        // MARK: - Init -
        
        init(client: APIClientProtocol = API.DefaultClient.shared) {
            self.client = client
        }
    }
}

// MARK: - Protocol methods -

extension Creator.Repository: CreatorRepositoryProtocol {
    func fetchCreators(with comicId: Int) -> AnyPublisher<Creator.ListResult, API.NetworkError> {
        let request = Creator.ListRequest(comicId: comicId)
        return client.request(request)
    }
}
