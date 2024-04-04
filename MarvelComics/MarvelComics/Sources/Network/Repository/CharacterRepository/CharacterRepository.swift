import Combine

extension Character {
    struct Repository: RepositoryProtocol {
        var client: APIClientProtocol
        
        // MARK: - Init -
        
        init(client: APIClientProtocol) {
            self.client = client
        }
    }
}

// MARK: - Protocol methods -

extension Character.Repository: CharacterRepositoryProtocol {
    func fetchCharacters() -> AnyPublisher<Character.ListResult, API.NetworkError> {
        let request = Character.ListRequest()
        return client.request(request)
    }
}
