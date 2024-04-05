import Combine

protocol CharacterRepositoryProtocol {
    func fetchCharacters(with offset: Int?) -> AnyPublisher<Character.ListResult, API.NetworkError>
}
