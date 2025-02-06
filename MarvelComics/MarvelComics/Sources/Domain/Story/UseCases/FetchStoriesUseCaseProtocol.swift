import Foundation
import Combine

protocol FetchStoriesUseCaseProtocol: UseCaseProtocol where Input == Int, Output == AnyPublisher<[Story.List.Model], ErrorModel> {
    func execute(input: Int) -> AnyPublisher<[Story.List.Model], ErrorModel>
}
