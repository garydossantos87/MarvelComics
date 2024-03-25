import Foundation

protocol ViewModelProtocol {
    var coordinator: BaseCoordinator? { get }
    
    init(coordinator: BaseCoordinator?)
}
