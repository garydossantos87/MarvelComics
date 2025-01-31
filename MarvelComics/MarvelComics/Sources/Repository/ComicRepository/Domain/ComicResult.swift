import Foundation

extension Comic {
    struct Result: Encodable, Decodable, Equatable {
        let id: Int
        let title: String
        let description: String?
        let dates: [DateResult]
        let prices: [PriceResult]
        let thumbnail: ThumbnailResult

        // MARK: - Init -

        public init(
            id: Int,
            title: String,
            description: String?,
            dates: [DateResult],
            prices: [PriceResult],
            thumbnail: ThumbnailResult
        ) {
            self.id = id
            self.title = title
            self.description = description
            self.dates = dates
            self.prices = prices
            self.thumbnail = thumbnail
        }
    }
}
