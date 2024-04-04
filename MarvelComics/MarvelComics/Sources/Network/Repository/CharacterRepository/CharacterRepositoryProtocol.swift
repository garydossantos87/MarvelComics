import Combine

protocol CharacterRepositoryProtocol {
    func fetchCharacters() -> AnyPublisher<Character.ListResult, API.NetworkError>
}
