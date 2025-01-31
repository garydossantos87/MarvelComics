import Foundation

struct PriceResult: Encodable, Decodable, Equatable {
    let type: String
    let price: Double

    // MARK: - Init -

    public init(type: String, price: Double) {
        self.type = type
        self.price = price
    }
}
