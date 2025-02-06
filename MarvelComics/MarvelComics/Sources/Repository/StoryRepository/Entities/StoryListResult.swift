import Foundation

extension Story {
    struct ListResult: Encodable, Decodable {
        let data: DataResult<Story.Result>
    }
}
