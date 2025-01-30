import Foundation
import Combine

protocol FetchComicsUseCaseProtocol: UseCaseProtocol where Input == Void, Output == AnyPublisher<[Comic.List.Model], API.NetworkError> {
    func execute() -> AnyPublisher<[Comic.List.Model], API.NetworkError>
}
