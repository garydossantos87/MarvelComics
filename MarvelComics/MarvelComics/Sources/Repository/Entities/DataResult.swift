import Foundation

struct DataResult<T: Encodable & Decodable & Equatable>: Encodable, Decodable, Equatable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
