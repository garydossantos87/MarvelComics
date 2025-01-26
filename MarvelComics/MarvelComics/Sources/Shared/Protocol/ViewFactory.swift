import UIKit

protocol ViewFactory {
    associatedtype CoordinatorType: BaseCoordinatorProtocol
    func make() -> UIViewController
    init(with coordinator: CoordinatorType)
}
