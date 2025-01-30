import Foundation

extension Serie {
    struct ListResult: Decodable {
        let data: DataResult<Serie.Result>
    }
}
