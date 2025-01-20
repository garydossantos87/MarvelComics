import Foundation
 
protocol RepositoryProtocol {
    var client: APIClientProtocol { get }
    
    init(client: APIClientProtocol)
}
