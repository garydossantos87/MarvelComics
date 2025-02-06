import Foundation

extension Creator {
    struct ListResult: Encodable, Decodable {
        let data: DataResult<Creator.Result>
    }
}
