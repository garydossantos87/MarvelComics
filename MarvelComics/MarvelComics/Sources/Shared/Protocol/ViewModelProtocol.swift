import Foundation

protocol ViewModelProtocol {
    associatedtype CoordinatorType: BaseCoordinatorProtocol
    var coordinator: CoordinatorType? { get }
    var state: ViewModelState? { get }
}
