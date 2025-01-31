import Foundation

struct PriceResult: Decodable {
    let type: String
    let price: Double

    // MARK: - Init -

    public init(type: String, price: Double) {
        self.type = type
        self.price = price
    }
}
