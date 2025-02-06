import UIKit

class ComicListCoordinator: BaseCoordinator, ComicListCoordinatorProtocol {
    func openComicDetail(with comic: Comic.List.Model) {
        guard let navigationController = navigationController else { return }
        let comicDetailVC = makeComicDetail(
            with: navigationController,
            comic: comic
        )
        handleNavigation(with: .push(viewController: comicDetailVC))
    }
    
    // MARK: - Private methods -
    
    private func makeComicDetail(
        with navigationController: UINavigationController?,
        comic: Comic.List.Model
    ) -> UIViewController {
        let coordinator = ComicDetailCoordinator(with: navigationController)
        return Comic.Detail.ViewFactory(
            with: coordinator,
            comic: comic
        )
        .make()
    }
}
