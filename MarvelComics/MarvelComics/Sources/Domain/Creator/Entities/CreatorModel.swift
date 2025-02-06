import Foundation
import UIKit

extension Creator.List {
    struct Model: Decodable {
        let id: Int
        let firstName: String
        let middleName: String?
        let fullName: String
        let date: Date?
        let thumbnail: URL?

        // MARK: - Init -

        public init(
            id: Int,
            firstName: String,
            middleName: String? = nil,
            fullName: String = "",
            date: Date? = nil,
            thumbnail: URL? = nil
        ) {
            self.id = id
            self.firstName = firstName
            self.middleName = middleName
            self.fullName = fullName
            self.date = date
            self.thumbnail = thumbnail
        }

        init(with dto: Creator.Result) {
            self.id = dto.id
            self.firstName = dto.firstName
            self.middleName = dto.middleName
            self.fullName = dto.fullName
            self.date = Date.fromString(dto.modified)
            self.thumbnail = dto.thumbnailURL
        }
    }
}

// MARK: - Private methods -

private extension Creator.Result {
    var thumbnailURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.formatExtension)")
    }
}
