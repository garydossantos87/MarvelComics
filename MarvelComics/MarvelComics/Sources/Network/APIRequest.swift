import Foundation

protocol APIRequest {
    associatedtype Response: Decodable

    var method: API.Method { get }
    var url: URL? { get }
    var parameters: [String: String]? { get }
}
