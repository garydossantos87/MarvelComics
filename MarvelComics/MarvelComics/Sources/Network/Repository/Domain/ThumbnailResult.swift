import Foundation

struct ThumbnailResult: Decodable {
    let path: String
    let formatExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case formatExtension = "extension"
    }
}
