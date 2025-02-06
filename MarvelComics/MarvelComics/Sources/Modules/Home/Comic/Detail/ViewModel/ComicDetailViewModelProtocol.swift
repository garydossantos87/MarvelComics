import Foundation

protocol ComicDetailViewModelProtocol: ViewModelProtocol where CoordinatorType == ComicDetailCoordinator {
    func onAppear()
    func onBackButtonClicked()
}
