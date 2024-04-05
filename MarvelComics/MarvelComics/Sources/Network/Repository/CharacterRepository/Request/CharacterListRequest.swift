import Foundation

extension Character {
    struct ListRequest: APIRequest {
        typealias Response = Character.ListResult
        
        let offset: Int
        var method: API.Method = .get
        var url: URL? { API.Endpoints.characters.url }
        var parameters: [String : String]? {
            API.RequestParametersFactory.shared
                .addOffsetHeader(type: .offset, offset: offset)
                .defaultHeaders
        }
    }
}
