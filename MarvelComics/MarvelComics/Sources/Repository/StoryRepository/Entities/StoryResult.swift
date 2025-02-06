import Foundation

enum Story {
    enum List {

    }
}

extension Story {
    struct Result: Encodable, Decodable, Equatable {
        let id: Int
        let title: String
        let type: String
        let modified: String
        let thumbnail: ThumbnailResult?
    }
}
