import Foundation

protocol CharacterDetailViewModelProtocol: ViewModelProtocol where CoordinatorType == CharacterDetailCoordinator {
    func onAppear()
    func onBackButtonClicked()
}
