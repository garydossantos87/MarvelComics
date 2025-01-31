import Combine
import Foundation

// MARK: - MockAPIClient -

extension API {
    final class MockAPIClient: APIClientProtocol {
        var result: Result<Data, API.NetworkError>?

        func request<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, API.NetworkError> {
            guard let result = result else {
                return Fail(error: .unknown(error: NSError(domain: "Mock Error", code: -1, userInfo: nil)))
                    .eraseToAnyPublisher()
            }

            return Future<T.Response, API.NetworkError> { promise in
                switch result {
                case .success(let data):
                    do {
                        let decodedResponse = try JSONDecoder().decode(T.Response.self, from: data)
                        promise(.success(decodedResponse))
                    } catch {
                        promise(.failure(.jsonDecodingError(error: error)))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
            .eraseToAnyPublisher()
        }
    }
}
