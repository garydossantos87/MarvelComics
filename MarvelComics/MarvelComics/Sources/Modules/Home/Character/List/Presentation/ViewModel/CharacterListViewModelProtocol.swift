import Foundation

protocol CharacterListViewModelProtocol: ViewModelProtocol {
    var showData: (() -> ())? { get set }
    var showError: ((String) -> ())? { get set }
    func loadData()
    func characterModel(at index: Int) -> Character.List.Model?
    func numberOfRowsInSection(section: Int) -> Int
    func onCharacterClicked(position: Int)
}
