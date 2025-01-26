import Foundation

protocol ComicListViewModelProtocol: ViewModelProtocol where CoordinatorType == ComicListCoordinator {
    func viewDidLoad()
    func comicModel(at index: Int) -> Comic.List.Model?
    func numberOfRowsInSection(section: Int) -> Int
    func numberOfSections() -> Int
}
