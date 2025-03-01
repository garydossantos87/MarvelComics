import Foundation

extension Character.List {
    struct Model: Decodable {
        let id: Int
        let name: String
        let description: String?
        let thumbnail: URL?
        let date: Date?
        
        // MARK: - Init -

        public init(
            id: Int,
            name: String,
            description: String? = nil,
            thumbnail: URL? = nil,
            date: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.thumbnail = thumbnail
            self.date = date
        }

        init(with dto: Character.Result) {
            self.id = dto.id
            self.name = dto.name
            self.description = dto.description
            self.thumbnail = dto.thumbnailURL
            self.date = Date.fromString(dto.date)
        }
    }
}

// MARK: - Private methods -

private extension Character.Result {
    var thumbnailURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.formatExtension)")
    }
}
