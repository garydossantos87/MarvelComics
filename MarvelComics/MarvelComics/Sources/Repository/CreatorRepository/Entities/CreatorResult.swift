import Foundation

enum Creator {
    enum List {

    }
}

extension Creator {
    struct Result: Encodable, Decodable, Equatable {
        let id: Int
        let firstName: String
        let middleName: String
        let fullName: String
        let modified: String
        let thumbnail: ThumbnailResult
    }
}
