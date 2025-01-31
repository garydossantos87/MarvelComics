import Foundation

extension Serie {
    struct Result: Decodable {
        let id: Int
        let title: String
        let description: String?
        let startYear: Int
        let endYear: Int
        let rating: String?
        let thumbnail: ThumbnailResult
    }
}
