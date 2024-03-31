import Combine
import Foundation

// MARK: - APIRequestProtocols -

protocol APIClientProtocol {
    func request<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error>
}

// MARK: - APIRequest -

extension API {
    final class DefaultClient: APIClientProtocol {
        private let session: URLSession
        
        // MARK: - Init -
        
        init(session: URLSession = .shared) {
            self.session = session
        }
        
        // MARK: - Private methods -
        
        /// Returns a URLRequest based on request parameters.
        /// - Parameter request: APIRequest object.
        /// - Returns: URLRequest type object based on requerst parameter.
        private func buildURLRequest<T: APIRequest>(with request: T) -> URLRequest? {
            guard let url = request.url else { return nil }
            
            var urlComponents = URLComponents(string: url.absoluteString)
            
            if request.method == .get {
                var queryItems = [URLQueryItem]()
                if let parameters = request.parameters {
                    parameters.forEach { queryItems.append(URLQueryItem(name: $0.key, value: $0.value))}
                    urlComponents?.queryItems = queryItems
                }
            }
           
            guard let finalURL = urlComponents?.url else { return nil }
//            var urlRequest = setupDefaultURLRequest(url: finalURL, method: request.method)
            var urlRequest = URLRequest(url: finalURL)
//            urlRequest.setValue("08c6fd830eb3f291f94cbe4f79432f45", forHTTPHeaderField: "apikey")
            urlRequest.httpMethod = request.method.rawValue.uppercased()

            if request.method != .get,
               let parameters = request.parameters,
                let body = try? JSONSerialization.data(withJSONObject: parameters as Any, options: []) {
                urlRequest.httpBody = body
            }
            return urlRequest
        }
        
//        private func setupDefaultURLRequest(url: URL, method: API.Method) -> URLRequest {
//            var urlRequest = URLRequest(url: url)
//            urlRequest.httpMethod = method.rawValue.uppercased()
//            guard let defaultHeaders = API.RequestHeaderFactory.shared.defaultHeaders else { return urlRequest }
//            defaultHeaders.forEach {
//                urlRequest.queryIte
//                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
//            }
//            print("*** Headers")
//            urlRequest.allHTTPHeaderFields?.forEach {
//                print("*** header \($0.key)")
//            }
//            return urlRequest
//        }
    }
}

// MARK: - Protocol methods -

extension API.DefaultClient {
    func request<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        guard let request = buildURLRequest(with: request) else {
            return Fail(error: API.NetworkError.invalidRequest)
                .eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request)
            .mapError { _
                in API.NetworkError.invalidRequest
            }
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw API.NetworkError.invalidRequest
                }
                return element.data
            }
            .decode(type: T.Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
