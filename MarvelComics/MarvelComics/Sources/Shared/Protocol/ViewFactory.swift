import UIKit

protocol ViewFactory {
    func make() -> UIViewController
    
    init(with apiClient: APIClientProtocol, coordinator: BaseCoordinator)
}
