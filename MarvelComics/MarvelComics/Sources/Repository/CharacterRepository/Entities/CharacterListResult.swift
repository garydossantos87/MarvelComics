import Foundation

extension Character {
    struct ListResult: Encodable, Decodable {
        let data: DataResult<Character.Result>
    }
}
