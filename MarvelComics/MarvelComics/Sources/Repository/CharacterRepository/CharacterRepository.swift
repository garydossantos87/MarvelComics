import Combine

extension Character {
    struct Repository: RepositoryProtocol {
        var client: APIClientProtocol
        
        // MARK: - Init -
        
        init(client: APIClientProtocol = API.DefaultClient.shared) {
            self.client = client
        }
    }
}

// MARK: - Protocol methods -

extension Character.Repository: CharacterRepositoryProtocol {
    func fetchCharacters(with offset: Int?) -> AnyPublisher<Character.ListResult, API.NetworkError> {
        let request = Character.ListRequest(offset: offset ?? 0)
        return client.request(request)
    }
}
