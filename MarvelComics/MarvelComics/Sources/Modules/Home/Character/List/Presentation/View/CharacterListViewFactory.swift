import UIKit

extension Character.List {
    struct ViewFactory {
        private let coordinator: BaseCoordinator

        // MARK: - Init -
        
        init(with coordinator: BaseCoordinator) {
            self.coordinator = coordinator
        }
    }
}

// MARK: - Protocol metods

extension Character.List.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let repository = Character.Repository()
        let useCases = UseCase.CharacterUseCases(with: repository)
        let viewModel = Character.List.ViewModel(
            coordinator: coordinator,
            useCases: useCases
        )
        return Character.List.ViewController(with: viewModel)
    }
}
