import Foundation

extension Serie {
    struct ListResult: Encodable, Decodable {
        let data: DataResult<Serie.Result>
    }
}
