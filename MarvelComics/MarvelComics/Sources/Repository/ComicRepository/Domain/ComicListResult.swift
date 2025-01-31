import Foundation

extension Comic {
    struct ListResult: Encodable, Decodable, Equatable {
        let data: DataResult<Comic.Result>
    }
}
