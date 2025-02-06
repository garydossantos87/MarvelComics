import Foundation
import UIKit

extension Story.List {
    struct Model: Decodable {
        let id: Int
        let title: String
        let type: Type
        let date: Date?
        let thumbnail: URL?

        // MARK: - Init -

        public init(
            id: Int,
            title: String,
            type: Type,
            date: Date? = nil,
            thumbnail: URL? = nil
        ) {
            self.id = id
            self.title = title
            self.type = type
            self.date = date
            self.thumbnail = thumbnail
        }

        init(with dto: Story.Result) {
            self.id = dto.id
            self.title = dto.title
            self.type = Type(rawValue: dto.type) ?? .none
            self.date = Date.fromString(dto.modified)
            self.thumbnail = dto.thumbnailURL
        }
    }
}

// MARK: - TypeModel -

extension Story.List.Model {
    enum `Type`: String, Decodable {
        case cover
        case story
        case none

        var name: String {
            switch self {
            case .cover: return "Cover"
            case .story: return "Story"
            case .none: return "IntroStory"
            }
        }
    }
}

// MARK: - Private methods -

private extension Story.Result {
    var thumbnailURL: URL? {
        guard let thumbnail else { return nil }
        return URL(string: "\(thumbnail.path).\(thumbnail.formatExtension)")
    }
}

