import Foundation

extension Character {
    struct ListResult: Decodable {
        let data: DataResult<Character.Result>
    }
}
