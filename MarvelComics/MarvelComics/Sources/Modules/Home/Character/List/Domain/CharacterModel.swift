import Foundation

extension Character.List {
    struct Model {
        let name: String
        let description: String?
        let thumbnail: URL?
        let date: Date?
        
        // MARK: - Init -
        
        init(with dto: Character.Result) {
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
