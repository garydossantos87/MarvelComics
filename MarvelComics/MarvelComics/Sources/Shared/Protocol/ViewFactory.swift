import UIKit

protocol ViewFactory {
    func make() -> UIViewController
    init(with coordinator: BaseCoordinator)
}
