import Foundation

protocol CharacterListViewModelProtocol: ViewModelProtocol where CoordinatorType == CharacterListCoordinator {
    func viewDidLoad()
    func loadData()
    func characterModel(at index: Int) -> Character.List.Model?
    func numberOfRowsInSection(section: Int) -> Int
    func onCharacterClicked(at index: Int)
    func onFilterCharacters(with query: String?)
}
