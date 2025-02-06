import Foundation

extension Creator {
    struct ListRequest: APIRequest {
        typealias Response = Creator.ListResult

        let comicId: Int
        var method: API.Method = .get
        var url: URL? { API.Endpoints.creators(comicId).url }
        var parameters: [String : String]? {
            API.RequestParametersFactory.shared
                .defaultHeaders
        }
    }
}
