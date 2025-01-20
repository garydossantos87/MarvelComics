import Foundation

protocol ViewModelProtocol {
    var coordinator: BaseCoordinator? { get }
    var state: ViewModelState? { get }
}
