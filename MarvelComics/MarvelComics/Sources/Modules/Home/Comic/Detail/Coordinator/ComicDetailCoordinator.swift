import UIKit

protocol ComicDetailCoordinatorProtocol: BaseCoordinatorProtocol {
    func openComicList()
}

final class ComicDetailCoordinator: BaseCoordinator, ComicDetailCoordinatorProtocol {
    func openComicList() {
    }
}
