import Foundation
import Combine

protocol FetchCharacterFromComicUseCaseProtocol: UseCaseProtocol where Input == Int, Output == AnyPublisher<[Character.List.Model], ErrorModel> {
    func execute(input: Int) -> AnyPublisher<[Character.List.Model], ErrorModel>
}
