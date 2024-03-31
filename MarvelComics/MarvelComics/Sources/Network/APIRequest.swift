import Foundation

//struct APIRequest<T: Decodable> {
//    let url: URL
//    let parameters: [String: CustomStringConvertible]
//    var urlRequest: URLRequest? {
//        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
//            return nil
//        }
//        components.queryItems = parameters.keys.map { key in
//            URLQueryItem(name: key, value: parameters[key]?.description)
//        }
//        guard let url = components.url else {
//            return nil
//        }
//        return URLRequest(url: url)
//    }
//
//    init(url: URL, parameters: [String: CustomStringConvertible] = [:]) {
//        self.url = url
//        self.parameters = parameters
//    }
//}
//
//import Foundation
//
//typealias Parameters = [String: String]
//
//enum HTTPMethod: String {
//    case get = "GET" // For this test, only Get is going to be used. However, other cases could be added.
//}

protocol APIRequest {

    associatedtype Response: Decodable

    var method: API.Method { get }
    var url: URL? { get }
    var parameters: [String: String]? { get }
}
