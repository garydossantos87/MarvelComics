import Combine

extension Serie {
    struct Repository: RepositoryProtocol {
        var client: APIClientProtocol
        
        // MARK: - Init -
        
        init(client: APIClientProtocol = API.DefaultClient.shared) {
            self.client = client
        }
    }
}

// MARK: - Protocol methods -

extension Serie.Repository: SerieRepositoryProtocol {
    func fetchSeries(with characterId: Int) -> AnyPublisher<Serie.ListResult, API.NetworkError> {
        let request = Serie.ListRequest(characterId: characterId)
        return client.request(request)
    }
}
