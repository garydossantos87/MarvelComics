import Foundation

extension Serie {
    struct ListRequest: APIRequest {
        typealias Response = Serie.ListResult

        let characterId: Int
        var method: API.Method = .get
        var url: URL? { API.Endpoints.series(characterId).url }
        var parameters: [String : String]? {
            API.RequestParametersFactory.shared
                .defaultHeaders
        }
    }
}
