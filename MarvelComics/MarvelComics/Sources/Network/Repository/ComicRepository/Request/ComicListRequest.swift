import Foundation

extension Comic {
    struct ListRequest: APIRequest {
        typealias Response = Comic.ListResult
        
        var method: API.Method = .get
        var url: URL? { API.Endpoints.comics.url }
        var parameters: [String : String]? {
            API.RequestHeaderFactory.shared
                .defaultHeaders
        }
    }
}
