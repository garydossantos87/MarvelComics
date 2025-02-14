import Combine
import Foundation
import MarvelComicsShared

// MARK: - MockUIAPIClient -

extension API {
    final class MockUIAPIClient: APIClientProtocol {
        var result: Result<Data, API.NetworkError>?
        
        func request<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, API.NetworkError> {
            var fileName: String = ""
            switch request {
            case is Comic.ListRequest:
                fileName += MocksUI.Constants.MocksResponse.getComics
            default:
                fileName += ""
            }
            
            guard let mockData = MocksUI.Helpers.loadJSONFromFile(named: fileName) else {
                return Fail(error: API.NetworkError.invalidResponse)
                    .eraseToAnyPublisher()
            }
            
            return Just(mockData)
                .decode(type: T.Response.self, decoder: JSONDecoder())
                .mapError { _ in API.NetworkError.jsonDecodingError(error: API.NetworkError.invalidResponse) }
                .eraseToAnyPublisher()
        }
    }
}
