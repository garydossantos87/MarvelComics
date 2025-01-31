import Foundation
import UIKit

extension Serie.List {
    struct Model: Decodable {
        let id: Int
        let title: String
        let description: String?
        let startYear: Int?
        let endYear: Int?
        let rating: RatingModel
        let thumbnail: URL?
        var formattedYears: String? {
            guard let startYear, let endYear else { return nil }
            return "\(startYear) - \(endYear)"
        }

        // MARK: - Init -

        public init(
            id: Int,
            title: String,
            description: String? = nil,
            startYear: Int? = nil,
            endYear: Int? = nil,
            rating: RatingModel,
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
            self.startYear = dto.startYear
            self.endYear = dto.endYear
            self.thumbnail = dto.thumbnailURL
            self.rating = RatingModel(rawValue: dto.rating ?? "") ?? .unrated
        }
    }
}

// MARK: - RatingModel -

extension Serie.List.Model {
    enum RatingModel: String, Decodable {
        case everyone = "E"
        case teen = "T"
        case teenPlus = "T+"
        case mature = "M"
        case unrated = ""

        var name: String {
            switch self {
            case .everyone, .unrated: return "Everyone"
            case .teen: return "Teen"
            case .teenPlus: return "Teen+"
            case .mature: return "Mature"
            }
        }

        var image: UIImage {
            switch self {
            case .everyone, .unrated: return UIImage.icnRatingEveryone
            case .teen: return UIImage.icnRatingTeen
            case .teenPlus: return UIImage.icnRatingTeenPlus
            case .mature: return UIImage.icnRatingMature
            }
        }
    }
}

// MARK: - Private methods -

private extension Serie.Result {
    var thumbnailURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.formatExtension)")
    }
}
