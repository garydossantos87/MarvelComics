import Foundation
 
protocol RepositoryProtocol {
    var client: APIClientProtocol { get }
    
    init(client: APIClientProtocol)
}

class BaseRepository {
    let client: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.client = client
    }
}
