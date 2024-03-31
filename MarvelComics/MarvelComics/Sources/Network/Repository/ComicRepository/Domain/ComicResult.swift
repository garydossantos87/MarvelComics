import Foundation

extension Comic {
    struct Result: Decodable {
        let id: Int
        let title: String
        let description: String?
        let dates: [DateResult]
        let prices: [PriceResult]
        let thumbnail: ThumbnailResult
    }
}
