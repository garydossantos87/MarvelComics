import Foundation

struct DateResult: Decodable {
    let type: String
    let date: String

    // MARK: - Init -

    public init(type: String, date: String) {
        self.type = type
        self.date = date
    }
}
