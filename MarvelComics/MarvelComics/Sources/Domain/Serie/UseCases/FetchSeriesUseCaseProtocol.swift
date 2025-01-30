import Foundation
import Combine

protocol FetchSeriesUseCaseProtocol: UseCaseProtocol where Input == Int, Output == AnyPublisher<[Serie.List.Model], API.NetworkError> {
    func execute(input: Int) -> AnyPublisher<[Serie.List.Model], API.NetworkError>
}
