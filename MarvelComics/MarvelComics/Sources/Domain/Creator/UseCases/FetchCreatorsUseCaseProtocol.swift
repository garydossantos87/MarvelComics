import Foundation
import Combine

protocol FetchCreatorsUseCaseProtocol: UseCaseProtocol where Input == Int, Output == AnyPublisher<[Creator.List.Model], ErrorModel> {
    func execute(input: Int) -> AnyPublisher<[Creator.List.Model], ErrorModel>
}
