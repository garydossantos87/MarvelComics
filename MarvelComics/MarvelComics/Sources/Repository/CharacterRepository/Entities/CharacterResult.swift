import Foundation

extension Character {
    struct Result: Decodable {
        let id: Int
        let name: String
        let description: String?
        let date: String
        let thumbnail: ThumbnailResult
        
        private enum CodingKeys: String, CodingKey {
            case id, name, description, thumbnail
            case date = "modified"
        }
    }
}
