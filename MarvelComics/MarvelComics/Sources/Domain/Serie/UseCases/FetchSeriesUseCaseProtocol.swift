import Foundation
import Combine

protocol FetchSeriesUseCaseProtocol: UseCaseProtocol where Input == Int, Output == AnyPublisher<[Serie.List.Model], ErrorModel> {
    func execute(input: Int) -> AnyPublisher<[Serie.List.Model], ErrorModel>
}
