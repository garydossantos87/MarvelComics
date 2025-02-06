import Foundation

// MARK: - Character list -

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

// MARK: - Character detail by comic -

extension Character {
    struct DetailRequest: APIRequest {
        typealias Response = Character.ListResult

        let comicId: Int
        var method: API.Method = .get
        var url: URL? { API.Endpoints.charactersForComic(comicId).url }
        var parameters: [String : String]? {
            API.RequestParametersFactory.shared
                .defaultHeaders
        }
    }
}

