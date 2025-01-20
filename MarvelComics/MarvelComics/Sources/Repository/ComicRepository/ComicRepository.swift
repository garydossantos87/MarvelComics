import Combine

extension Comic {
    struct Repository: RepositoryProtocol {
        var client: APIClientProtocol
        
        // MARK: - Init -
        
        init(client: APIClientProtocol) {
            self.client = client
        }
    }
}

// MARK: - Protocol methods -

extension Comic.Repository: ComicRepositoryProtocol {
    func fetchComics() -> AnyPublisher<Comic.ListResult, API.NetworkError> {
        let request = Comic.ListRequest()
        return client.request(request)
    }
}
