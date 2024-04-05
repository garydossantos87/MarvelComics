import Foundation

protocol CharacterListViewModelProtocol: ViewModelProtocol {
    func loadData()
    func characterModel(at index: Int) -> Character.List.Model?
    func numberOfRowsInSection(section: Int) -> Int
    var showData: (() -> ())? { get set }
    var showError: ((String) -> ())? { get set }
}
