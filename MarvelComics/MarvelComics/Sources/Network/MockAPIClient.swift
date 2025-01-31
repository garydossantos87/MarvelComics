import Combine
import Foundation

// MARK: - MockAPIClient -

extension API {
    final class MockAPIClient: APIClientProtocol {
        var response: Any?
        var error: API.NetworkError?

        func request<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, API.NetworkError> {
            if let error = error {
                return Fail(error: error).eraseToAnyPublisher()
            }

            if let response = response as? T.Response {
                return Just(response)
                    .setFailureType(to: API.NetworkError.self)
                    .eraseToAnyPublisher()
            }

            return Fail(error: .unknown(error: NSError(domain: "Mock Error", code: -1, userInfo: nil)))
                .eraseToAnyPublisher()
        }
    }
}
