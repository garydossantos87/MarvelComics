import Foundation

extension Serie {
    struct Result: Decodable {
        let id: Int
        let title: String
        let description: String?
        let startYear: String
        let endYear: String
        let rating: String?
        let thumbnail: ThumbnailResult
    }
}
