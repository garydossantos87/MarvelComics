import Foundation

extension Character {
    class PaginationModel: Pagination {
        let results: [List.Model]
        
        // MARK: - Init -
        
        init(with dto: ListResult) {
            results = dto.data.results.map { List.Model(with: $0) }
            super.init(offset: dto.data.offset, limit: dto.data.limit, total: dto.data.total, count: dto.data.count)
        }
        
        init(with dto: ListResult, oldCharacters: [List.Model]?) {
            if let oldCharacters = oldCharacters {
                results = oldCharacters + dto.data.results.map { List.Model(with: $0) }
            } else {
                results = dto.data.results.map { List.Model(with: $0) }
            }
            super.init(offset: results.count, limit: dto.data.limit, total: dto.data.total, count: dto.data.count)
        }
        
        required init(from decoder: Decoder) throws {
            fatalError("init(from:) has not been implemented")
        }
    }
}
