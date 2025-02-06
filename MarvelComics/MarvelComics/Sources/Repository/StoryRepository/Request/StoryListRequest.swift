import Foundation

extension Story {
    struct ListRequest: APIRequest {
        typealias Response = Story.ListResult

        let comicId: Int
        var method: API.Method = .get
        var url: URL? { API.Endpoints.stories(comicId).url }
        var parameters: [String : String]? {
            API.RequestParametersFactory.shared
                .defaultHeaders
        }
    }
}
