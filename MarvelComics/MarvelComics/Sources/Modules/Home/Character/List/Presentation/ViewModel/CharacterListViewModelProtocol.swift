import Foundation

protocol CharacterListViewModelProtocol: ViewModelProtocol {
    func viewDidLoad()
    func loadData()
    func characterModel(at index: Int) -> Character.List.Model?
    func numberOfRowsInSection(section: Int) -> Int
    func onCharacterClicked(position: Int)
}
