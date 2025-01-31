import Foundation

struct ThumbnailResult: Decodable {
    let path: String
    let formatExtension: String

    // MARK: - Init -

    public init(path: String, formatExtension: String) {
        self.path = path
        self.formatExtension = formatExtension
    }

    private enum CodingKeys: String, CodingKey {
        case path
        case formatExtension = "extension"
    }
}
