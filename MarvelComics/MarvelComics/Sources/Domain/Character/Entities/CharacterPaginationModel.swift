import Foundation

extension Character {
    class PaginationModel: Pagination {
        let results: [List.Model]
        
        // MARK: - Init -
        
        init(with dto: ListResult) {
            results = dto.data.results.map { List.Model(with: $0) }
            super.init(offset: dto.data.offset, limit: dto.data.limit, total: dto.data.total, count: dto.data.count)
        }
        
        init(with paginationModel: PaginationModel, oldCharacters: [List.Model]?) {
            if let oldCharacters = oldCharacters {
                results = oldCharacters + paginationModel.results
            } else {
                results = paginationModel.results
            }
            super.init(offset: results.count, limit: paginationModel.limit, total: paginationModel.total, count: paginationModel.count)
        }

        required init(from decoder: Decoder) throws {
            fatalError("init(from:) has not been implemented")
        }
    }
}
