import Foundation

extension Comic {
    struct ListResult: Decodable {
        let data: DataResult<Comic.Result>
    }
}
