import Foundation

extension Serie.List {
    struct Model: Decodable {
        let id: Int
        let title: String
        let description: String?
        let startYear: Date?
        let endYear: Date?
        let rating: String?
        let thumbnail: URL?

        // MARK: - Init -

        public init(
            id: Int,
            title: String,
            description: String? = nil,
            startYear: Date? = nil,
            endYear: Date? = nil,
            rating: String? = nil,
            thumbnail: URL? = nil
        ) {
            self.id = id
            self.title = title
            self.description = description
            self.startYear = startYear
            self.endYear = endYear
            self.rating = rating
            self.thumbnail = thumbnail
        }

        init(with dto: Serie.Result) {
            self.id = dto.id
            self.title = dto.title
            self.description = dto.description
            self.startYear = Date.fromString(dto.startYear)
            self.endYear = Date.fromString(dto.endYear)
            self.thumbnail = dto.thumbnailURL
            self.rating = dto.rating
        }
    }
}

// MARK: - Private methods -

private extension Serie.Result {
    var thumbnailURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.formatExtension)")
    }
}
